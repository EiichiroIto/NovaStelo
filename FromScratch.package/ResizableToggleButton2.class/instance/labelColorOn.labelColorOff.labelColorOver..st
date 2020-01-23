private
labelColorOn: onColor labelColorOff: offColor labelColorOver: overColor
	
	labelColorOn := onColor.
	labelColorOff := offColor.
	labelColorOver := overColor.
	isOn ifTrue: [ label2 color: onColor ] ifFalse: [ label2 color: offColor ].
