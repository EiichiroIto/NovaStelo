event handling
mouseMove: evt
 
	| containsPoint |
	actWhen = #buttonDown ifTrue: [^ self].

	containsPoint := self containsPoint: evt cursorPoint.
	toggleButtonMode
		ifFalse: [
			containsPoint
				ifTrue: [isOn ifFalse: [self on]]
				ifFalse: [isOn ifTrue: [self off]]]
		ifTrue: [
			toggleMode
				ifTrue: [
					containsPoint
						ifTrue: [
							wasOn
								ifTrue: [isOn ifTrue: [isOn := false. self over]]
								ifFalse: [isOn ifTrue: [^ self] ifFalse: [self on]]]
						ifFalse: [
							wasOn
								ifTrue: [isOn ifFalse: [self on]]
								ifFalse: [isOn ifTrue: [self off]]]]
				ifFalse: [
					containsPoint
						ifTrue: [
							wasOn
								ifTrue: [^ self]
								ifFalse: [isOn ifFalse: [self on]]]
						ifFalse: [
							wasOn
								ifTrue: [^ self]
								ifFalse: [isOn ifTrue: [isOn := false. self over]]]]].
