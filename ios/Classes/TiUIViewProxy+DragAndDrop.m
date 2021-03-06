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

  UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
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

  UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
  [view addInteraction:dropInteraction];
}

@end
