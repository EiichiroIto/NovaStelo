private
updateDontCloseSetting
	| win |
	win := 	self window window.
	self application class dontClose
		ifTrue: [ win makeUnclosable ]
		ifFalse: [ win makeClosable ]