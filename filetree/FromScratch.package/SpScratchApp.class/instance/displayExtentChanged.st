change reporting
displayExtentChanged
	self class keepMaximize
		ifFalse: [ ^ self ].
	presenter window window fullscreen