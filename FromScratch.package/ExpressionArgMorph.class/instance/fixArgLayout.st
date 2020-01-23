private
fixArgLayout
	| top xInset extraW |
	top := self top.
	isNumber
		ifTrue: [ self extent: labelMorph extent + (5 @ 0).
			"tiny vertical adjustment to account for differences in string rendering"
			"Smalltalk isWindows ifFalse: ["
			top := top + 1.	"]"
			"for tall fonts, add extra width"
			extraW := self height - (1.3 * self width) rounded max: 0.
			extraW > 0
				ifTrue: [ self width: self width + extraW ].
			xInset := 4 + (extraW // 2) ]
		ifFalse: [ self extent: labelMorph extent + (2 @ 0).
			xInset := 3 ].
	labelMorph position: (self left + xInset) @ top