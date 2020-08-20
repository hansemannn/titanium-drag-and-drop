//
//  TiUIViewProxy+DragAndDrop.h
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#define USE_TI_UISCROLLVIEW // Enable access to the core class

#import <TitaniumKit/TitaniumKit.h>
#import "TiDraganddropModule.h"
#import "TiUIScrollViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiUIScrollViewProxy (DragAndDrop) <TiDragAndDroppable>

@end

NS_ASSUME_NONNULL_END
