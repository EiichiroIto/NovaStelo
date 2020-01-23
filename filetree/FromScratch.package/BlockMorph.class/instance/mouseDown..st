event handling
mouseDown: evt
	"Handle a mouse click. Left button either drags or performs click action. Right button brings up a menu."

	evt hand newKeyboardFocus: nil.
	evt yellowButtonPressed
		ifTrue: [ Sensor waitNoButton.
			^ self rightButtonMenu: evt ].
	evt hand waitForClicksOrDrag: self event: evt