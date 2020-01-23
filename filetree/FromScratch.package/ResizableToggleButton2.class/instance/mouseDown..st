event handling
mouseDown: evt

	"evt hand toolType: nil."
	wasOn := isOn.

	evt hand newKeyboardFocus: nil.

	evt yellowButtonPressed ifTrue: [
		Sensor waitNoButton.
		^ self rightButtonMenu].

	toggleButtonMode
		ifTrue: [
			toggleMode
				ifTrue: [
					isOn
						ifTrue: [isOn := false. self over]
						ifFalse: [self on]]

				ifFalse: [
					isOn
						ifTrue: [^ self]
						ifFalse: [self on]]]
		ifFalse: [self on].

	actWhen = #buttonDown ifTrue: [
		self doButtonAction.
		self off].
