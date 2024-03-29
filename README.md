# Titanium Drag and Drop

Native cross platform "Drag and Drop" functionality in Titanium.

<img src="./example.gif" height="500" alt="Example video" />

## Requirements

- iOS 11+
- Android 5+

## Example

```js
import DragDrop from 'ti.draganddrop';

const win = Ti.UI.createWindow({
    backgroundColor: '#e0e0e0'
});

const dragView = Ti.UI.createView({
	width: 100,
	height: 100,
	backgroundColor: 'red',
	borderRadius: 20,
	identifier: '123' // REQUIRED
});

const dropView = Ti.UI.createView({
	height: 200,
	bottom: 0,
	backgroundColor: '#fff',
	identifier: '456' // REQUIRED
});

win.add(dragView);
win.add(dropView);

DragDrop.addEventListener('drag', () => console.warn);
DragDrop.addEventListener('drop', () => console.warn);
DragDrop.addEventListener('dropenter', () => console.warn);
DragDrop.addEventListener('dropexit', () => console.warn);

win.addEventListener('postlayout', initializeDragAndDrop);
win.open();

// Important: You have to wait for the "postlayout" event to assign the drop and drop properties,
// because they require the native view to be present already
function initializeDragAndDrop() {
	dragView.canDrag = true;
	dropView.canDrop = true;
}
```

## Difference to TiDev's `Ti.DragDrop`

The [Ti.DragDrop](https://github.com/tidev/ti.dragdrop) module works quite differently than this one. Major differences are:
- This module uses lightweight identifiers instead of proxy references that have to be stored in memory, resulting in better performance
- This module support multiple drop destinations, e.g. for file explorer views
- This module supports not only classic `Ti.UI.View` instances, but also the `Ti.UI.ScrollView`. Other views like `ImageView` and `Label` can
be extended with the given delegate
- Ti.DragDrop also supports drag-and-drop between apps. If you need that functionality rather than in-app drag-and-drop, consider using that one instead

## License

MIT

## Author

Hans Knöchel ([@hansemannn](https://github.com/hansemannn))
