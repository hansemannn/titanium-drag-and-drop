//
//  TiUIViewProxy+DragAndDrop.m
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#import "TiUIScrollViewProxy+DragAndDrop.h"
#import "TiDraganddropModule.h"
#import "TiUIScrollView.h"

@implementation TiUIScrollViewProxy (DragAndDrop)

// MARK: Public APIs

- (void)setCanDrag:(NSNumber *)value
{
  ENSURE_UI_THREAD(setCanDrag, value);

  if ([self valueForKey:@"identifier"] == nil) {
    DebugLog(@"[ERROR] Missing \"identifier\" property. Please set this property to identify a drag item");
    return;
  }

  UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
  dragInteraction.enabled = YES;

  [[self scrollView] addInteraction:dragInteraction];
  [self scrollView].userInteractionEnabled = YES;
}

- (void)setCanDrop:(NSNumber *)value
{
  ENSURE_UI_THREAD(setCanDrop, value);

  if ([self valueForKey:@"identifier"] == nil) {
    DebugLog(@"[ERROR] Missing \"identifier\" property. Please set this property to identify a drop item");
    return;
  }

  UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
  [[self scrollView] addInteraction:dropInteraction];
}

// MARK: Utils

- (__kindof TiUIScrollView *)scrollView
{
  return (TiUIScrollView *)[self view];
}

@end
