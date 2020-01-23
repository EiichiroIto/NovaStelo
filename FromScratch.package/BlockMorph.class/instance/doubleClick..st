event handling
doubleClick: evt
	"If I'm a block with a receiver that's in a Scratch window, execute me."

	self topBlock toggleProcess.
