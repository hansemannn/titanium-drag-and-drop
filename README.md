# Titanium Drag and Drop

Native cross platform "Drag and Drop" functionality in Axway Titanium.

## Requirements

- iOS 11+
- Android 5+

## Example

```js
var DragDrop = require('ti.draganddrop');

var win = Ti.UI.createWindow({
    backgroundColor: '#e0e0e0'
});

var dragView = Ti.UI.createView({ width: 100, height: 100, backgroundColor: 'red', borderRadius: 20, identifier: '123' });
win.add(dragView);

var dropView = Ti.UI.createView({ height: 200, bottom: 0, backgroundColor: '#fff', identifier: '456' });
win.add(dropView);

DragDrop.addEventListener('drop', console.warn);

win.addEventListener('postlayout', initializeDragAndDrop);
win.open();

// Important: You have to wait for the "postlayout" event to assign the drop and drop properties,
// because they require the native view to be present already
function initializeDragAndDrop() {
	dragView.canDrag = true;
	dropView.canDrop = true;
}
```

## Difference to Axway's `Ti.DragDrop`

The [Ti.DragDrop](https://github.com/appcelerator-modules/ti.dragdrop) module works quite differently than this one. Major differences are:
- This module uses lightweight identifiers instead of proxy references that have to be stored in memory, resulting in better performance
- This module support multiple drop destinations, e.g. for file explorer views
- This module supports not only classic `Ti.UI.View` instances, but also the `Ti.UI.ScrollView`. Other views like `ImageView` and `Label` can
be extended with the given delegate
- Ti.DragDrop also supports drag-and-drop between apps. If you need that functionality rather than in-app drag-and-drop, consider using that one instead

## License

MIT

## Author

Hans Knöchel ([@hansemannn](https://github.com/hansemannn))