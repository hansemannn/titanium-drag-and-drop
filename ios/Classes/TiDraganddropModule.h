//
//  TiUIViewProxy+DragAndDrop.h
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#import "TiModule.h"

@protocol TiDragAndDroppable <NSObject>

@required
- (void)enableDragging:(id)unused;

@required
- (void)enableDropping:(id)unused;

@end

@interface TiDraganddropModule : TiModule  <UIDragInteractionDelegate, UIDropInteractionDelegate>

+ (TiDraganddropModule *)instance;

@end
