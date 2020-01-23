private
doDoubleClickAt: aPoint
	| pos |
	aPoint >= offset
		ifFalse: [ ^ self ].
	aPoint < (offset + (cell * modelExtent))
		ifFalse: [ ^ self ].
	pos := self pointOf: aPoint.
	whenDoubleClickDo ifNotNil: [ whenDoubleClickDo cull: pos ]