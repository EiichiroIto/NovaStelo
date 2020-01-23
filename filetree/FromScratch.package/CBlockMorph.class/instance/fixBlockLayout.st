drawing
fixBlockLayout
	"Update the positions of my submorphs."

	| oldExtent newW newH f |
	blockLayoutNeeded
		ifFalse: [ ^ self ].
	super fixBlockLayout.

	"fix nestedBlock and nextBlock in case they've been removed from me"
	(nestedBlock notNil and: [ nestedBlock owner ~~ self ])
		ifTrue: [ nestedBlock := nil ].
	(nextBlock notNil and: [ nextBlock owner ~~ self ])
		ifTrue: [ nextBlock := nil ].
	oldExtent := self extent.
	newW := oldExtent x max: 40.
	newH := self topBarHeight + CBlockBracketThickness.
	self isForever
		ifFalse: [ newH := newH + 4 ].
	nestedBlock
		ifNil: [ newH := newH + 14 ]
		ifNotNil: [ stretchHeight := 0.
			nestedBlock fixBlockLayout.
			newH := newH + nestedBlock fullBounds height - 1.
			nestedBlock
				position: self position + (CBlockBracketThickness @ (self topBarHeight + 3)).
			nestedBlock blockSequence last isStopOrForever
				ifTrue: [ newH := newH + 4 ] ].
	self extent: newW @ newH + (0 @ stretchHeight).

	"position loop morph"
	loopMorph
		ifNotNil: [ f := ScratchTheme formAt: #loopIcon.
			loopMorph form: f.
			self isForever
				ifTrue: [ loopMorph position: self bottomRight - loopMorph extent - (4 @ 2) ]
				ifFalse: [ loopMorph position: self bottomRight - loopMorph extent - (4 @ 6) ] ].
	nextBlock
		ifNotNil: [ nextBlock position: self left @ (self bottom - 4) ]