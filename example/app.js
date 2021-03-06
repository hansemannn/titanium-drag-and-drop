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

DragDrop.addEventListener('drop', console.warn);

win.addEventListener('postlayout', initializeDragAndDrop);
win.open();

// Important: You have to wait for the "postlayout" event to assign the drop and drop properties,
// because they require the native view to be present already
function initializeDragAndDrop() {
	dragView.canDrag = true;
	dropView.canDrop = true;
}