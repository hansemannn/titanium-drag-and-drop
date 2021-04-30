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

- (void)enableDragging:(id)unused
{
  __weak typeof(self) weakSelf = self;
  TiThreadPerformOnMainThread(^{
    __strong typeof(self) strongSelf = weakSelf;

    UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
    dragInteraction.enabled = YES;

    [[strongSelf scrollView] addInteraction:dragInteraction];
    [strongSelf scrollView].userInteractionEnabled = YES;
  }, NO);
}

- (void)enableDropping:(id)unused
{
  __weak typeof(self) weakSelf = self;
  TiThreadPerformOnMainThread(^{
    __strong typeof(self) strongSelf = weakSelf;

    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:[TiDraganddropModule instance]];
    [[strongSelf scrollView] addInteraction:dropInteraction];
  }, NO);
}

// MARK: Utils

- (__kindof TiUIScrollView *)scrollView
{
  return (TiUIScrollView *)[self view];
}

@end
