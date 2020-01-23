event handling
click: evt
	"If a tool is selected, handle a click with that tool. Otherwise, toggle my process."

	self topBlock toggleProcess.
