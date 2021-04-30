//
//  TiUIViewProxy+DragAndDrop.h
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#define USE_TI_UISCROLLVIEW

#import "TiDraganddropModule.h"
#import <TitaniumKit/TitaniumKit.h>
#import "TiUIScrollView.h"

@implementation TiDraganddropModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"b8a04d3b-16c8-4f30-806e-de07b8ae9a6d";
}

- (NSString *)moduleId
{
  return @"ti.draganddrop";
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
      [self fireEvent:@"drop" withObject:@{
        @"from": fromIdentifier,
        @"to": toIdentifier
      }];
    }, NO);
  }];
}

#pragma mark Utils

- (NSString *)identifierFromView:(id)view
{
  if ([view isKindOfClass:[TiUIView class]]) {
    return [((TiUIView *)view).proxy valueForKey:@"identifier"];
  } else if ([view isKindOfClass:[TiUIScrollViewImpl class]]) {
    return [((TiUIScrollView *)view).proxy valueForKey:@"identifier"];
  } else {
    NSLog(@"[ERROR] Cannot unwrap native view (probably not supported in this module so far)");
    return nil;
  }
}

+ (TiDraganddropModule *)instance
{
  NSDictionary<NSString *, TiModule *> *modules = [TiApp.app valueForKey:@"modules"];
  TiDraganddropModule *instance = (TiDraganddropModule *) modules[@"TiDraganddropModule"];
  
  return instance;
}

@end
