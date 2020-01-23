private
fixBlockLayout
	"Update the positions of my submorphs."

	| newH |
	blockLayoutNeeded
		ifFalse: [ ^ self ].

	"fix trueBlock, falseBlock, and nextBlock in case they've been removed from me"
	(trueBlock notNil and: [ trueBlock owner ~~ self ])
		ifTrue: [ trueBlock := nil ].
	(falseBlock notNil and: [ falseBlock owner ~~ self ])
		ifTrue: [ falseBlock := nil ].
	(nextBlock notNil and: [ nextBlock owner ~~ self ])
		ifTrue: [ nextBlock := nil ].
	super fixBlockLayout.
	newH := self topBarHeight + 3.
	trueBlock
		ifNil: [ newH := newH + 15 ]
		ifNotNil: [ trueBlock fixBlockLayout.
			trueBlock position: self position + (CBlockBracketThickness @ newH).
			newH := newH + trueBlock fullBounds height.
			trueBlock blockSequence last isStopOrForever
				ifTrue: [ newH := newH + 4 ] ].
	elseBarY := newH - 4.
	newH := newH + self elseBarHeight + 1.
	falseBlock
		ifNil: [ newH := newH + 15 ]
		ifNotNil: [ falseBlock fixBlockLayout.
			falseBlock
				position: self position + (CBlockBracketThickness @ newH).
			newH := newH + falseBlock fullBounds height.
			falseBlock blockSequence last isStopOrForever
				ifTrue: [ newH := newH + 4 ] ].
	newH := newH + CBlockBracketThickness.
	self height: newH.
	nextBlock
		ifNotNil: [ nextBlock position: self left @ (self bottom - 4) ].
	elseMorph
		position:
			(self left + 6)
				@
					(self top + elseBarY
						+
							((ScratchTranslator
								centerOffsetForButtonWithFont: ScratchTheme labelFont) // 4))