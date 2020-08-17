//
//  TiUIViewProxy+DragAndDrop.m
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#import "TiUIViewProxy+DragAndDrop.h"
#import "TiDraganddropModule.h"

@implementation TiUIViewProxy (DragAndDrop)

// MARK: Public APIs

- (void)setCanDrag:(NSNumber *)value
{
  ENSURE_UI_THREAD(setCanDrag, value);

  if ([self valueForKey:@"identifier"] == nil) {
    DebugLog(@"[ERROR] Missing \"identifier\" property. Please set this property to identify a drag item");
    return;
  }

  UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
  dragInteraction.enabled = YES;

  [view addInteraction:dragInteraction];
  view.userInteractionEnabled = YES;
}

- (void)setCanDrop:(NSNumber *)value
{
  ENSURE_UI_THREAD(setCanDrop, value);

  if ([self valueForKey:@"identifier"] == nil) {
    DebugLog(@"[ERROR] Missing \"identifier\" property. Please set this property to identify a drop item");
    return;
  }

  UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
  [view addInteraction:dropInteraction];
}

// MARK: UIDragInteractionDelegate

- (nonnull NSArray<UIDragItem *> *)dragInteraction:(nonnull UIDragInteraction *)interaction itemsForBeginningSession:(nonnull id<UIDragSession>)session
{
  NSString *value = [self identifierFromView:interaction.view];

  UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:[[NSItemProvider alloc] initWithObject:value]];
  item.localObject = value;

  return @[ item ];
}

// MARK: UIDropInteractionDelegate

- (BOOL)dropInteraction:(UIDropInteraction *)interaction canHandleSession:(id<UIDropSession>)session
{
  return [self identifierFromView:interaction.view] != nil; // Only allow dropping if the view has an identifier
}

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction sessionDidUpdate:(id<UIDropSession>)session
{
  NSString *value = [self identifierFromView:interaction.view];
  [self fireEvent:@"update" withObject:@{ @"from": value }];

  UIDropOperation operation = UIDropOperationCopy; // TODO: Make configurable via "dropOperation" property

  return [[UIDropProposal alloc] initWithDropOperation:operation];
}

- (void)dropInteraction:(UIDropInteraction *)interaction performDrop:(id<UIDropSession>)session
{
  if (![session canLoadObjectsOfClass:[NSString class]]) { return; }

  NSItemProvider *itemProvider = session.items.firstObject.itemProvider;

  [itemProvider loadObjectOfClass:[NSString class] completionHandler:^(id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
    NSString *fromIdentifier = (NSString *)object;
    NSString *toIdentifier = [self identifierFromView:interaction.view];

    TiThreadPerformOnMainThread(^{
      NSDictionary<NSString *, TiModule *> *modules = [TiApp.app.krollBridge valueForKey:@"modules"];
      TiDraganddropModule *moduleInstance = (TiDraganddropModule *) modules[@"ti.draganddrop"];
      
      [moduleInstance fireEvent:@"drop" withObject:@{
        @"from": fromIdentifier,
        @"to": toIdentifier
      }];
    }, NO);
  }];
}

- (NSString *)identifierFromView:(id)view
{
  return [[(TiUIView *)view proxy] valueForKey:@"identifier"];;
}

@end
