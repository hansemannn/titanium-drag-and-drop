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

- (void)enableDragging:(id)unused
{
  __weak typeof(self) weakSelf = self;
  TiThreadPerformOnMainThread(^{
    __strong typeof(self) strongSelf = weakSelf;

    UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
    dragInteraction.enabled = YES;

    [strongSelf.view addInteraction:dragInteraction];
    strongSelf.view.userInteractionEnabled = YES;
  }, NO);
}

- (void)enableDropping:(id)unused
{
  __weak typeof(self) weakSelf = self;
  TiThreadPerformOnMainThread(^{
    __strong typeof(self) strongSelf = weakSelf;

    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
    [strongSelf.view addInteraction:dropInteraction];
  }, NO);
}

@end
