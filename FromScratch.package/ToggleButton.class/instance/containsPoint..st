geometry
containsPoint: aPoint

	| f |
	(self bounds containsPoint: aPoint) ifFalse: [^ false].
	f := isOn ifTrue: [onForm] ifFalse: [offForm].
	f ifNil: [^ true].
	^ (f isTransparentAt: aPoint - bounds origin) not
