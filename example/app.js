var DragDrop = require('ti.draganddrop');
const { func } = require('assert-plus');
var win = Ti.UI.createWindow({
    backgroundColor: '#e0e0e0'
});

var dragView = Ti.UI.createView({ width: 100, height: 100, backgroundColor: 'red', borderRadius: 20 });
win.add(dragView);

var dropView = Ti.UI.createView({ height: 200, bottom: 0, backgroundColor: '#fff' });
win.add(dropView);

DragDrop.addEventListener('drop', console.warn);

win.addEventListener('postlayout', initializeDragAndDrop);
win.open();

function initializeDragAndDrop() {
	dragView.canDrag = true;
	dropView.canDrop = true;
}
