//
//  TiUIViewProxy+DragAndDrop.h
//  titanium-drag-and-drop
//
//  Created by Hans Knoechel on 17.08.20.
//

#import <TitaniumKit/TitaniumKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiUIViewProxy (DragAndDrop) <UIDragInteractionDelegate, UIDropInteractionDelegate>

- (void)setCanDrag:(NSNumber *)value;

- (void)setCanDrop:(NSNumber *)value;

@end

NS_ASSUME_NONNULL_END
