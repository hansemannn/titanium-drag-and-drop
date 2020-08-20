//
//  TiUIViewProxy+DragAndDrop.h
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#import "TiModule.h"

@protocol TiDragAndDroppable <NSObject>

@required
- (void)setCanDrag:(NSNumber *)value;

@required
- (void)setCanDrop:(NSNumber *)value;

@end

@interface TiDraganddropModule : TiModule  <UIDragInteractionDelegate, UIDropInteractionDelegate>

+ (TiDraganddropModule *)instance;

@end
