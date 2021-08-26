"
I am an ""E"" shaped block used for the if-then-else control structure.

"
Class {
	#name : #IfElseBlockMorph,
	#superclass : #CommandBlockMorph,
	#instVars : [
		'trueBlock',
		'falseBlock',
		'nextBlock',
		'elseBarY',
		'topBarBottom',
		'blockBottom',
		'elseMorph'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #private }
IfElseBlockMorph >> addLabel [
	"Also add the else label"

	super addLabel.
	elseMorph := self labelMorphFor: 'else' localized.
	self addMorphBack: elseMorph.

]

{ #category : #private }
IfElseBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	| blockTuple arg argList |
	blockTuple := Array new: argMorphs size + 3.
	blockTuple at: 1 put: selector.

	argList := argMorphs.
	argList := self organizeArgs: argList.
	1 to: argList size do: [:i |
		arg := argList at: i.
		(arg isKindOf: ArgMorph)
			ifTrue: [blockTuple at: i + 1 put: arg evaluate]
			ifFalse: [blockTuple at: i + 1 put: arg asBlockTuple]].

	trueBlock
		ifNil: [blockTuple at: blockTuple size - 1 put: nil]
		ifNotNil: [blockTuple at: blockTuple size - 1 put: trueBlock tupleSequence].

	falseBlock
		ifNil: [blockTuple at: blockTuple size put: nil]
		ifNotNil: [blockTuple at: blockTuple size put: falseBlock tupleSequence].

	^ blockTuple

]

{ #category : #private }
IfElseBlockMorph >> attachBlock: aBlockMorph [
	"Attach the given block to me. Assume the block has been positioned correctly."

	| y |
	self addMorph: aBlockMorph.
	y := aBlockMorph top.
	y <= (self top + elseBarY) ifTrue: [trueBlock := aBlockMorph. ^ self].
	y <= (self bottom - CBlockBracketThickness) ifTrue: [falseBlock := aBlockMorph. ^ self].
	nextBlock := aBlockMorph.


]

{ #category : #private }
IfElseBlockMorph >> blockAttachPoints: aSet [
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping command block could be attached."

	| result |
	result := #().
	self = self topBlock
		ifTrue: [ result := result copyWith: self topLeft -> self ].
	(self isKindOf: HatBlockMorph)
		ifFalse: [ result := result copyWith: self topLeft -> self ].
	trueBlock
		ifNil: [ result := result
				copyWith: self topLeft + (12 @ (self topBarHeight + 7)) -> self ]
		ifNotNil: [ trueBlock blockAttachPoints: aSet ].
	falseBlock
		ifNil: [ result := result
				copyWith: self topLeft + (12 @ (elseBarY + self elseBarHeight + 9)) -> self ]
		ifNotNil: [ falseBlock blockAttachPoints: aSet ].
	nextBlock
		ifNil: [ result := result copyWith: self bottomLeft -> self ]
		ifNotNil: [ nextBlock blockAttachPoints: aSet ].
	aSet addAll: result
]

{ #category : #geometry }
IfElseBlockMorph >> containsPoint: aPoint [

	cachedForm ifNil: [self updateCachedForm].
	^ (self fullBounds containsPoint: aPoint) and:
	  [(cachedForm isTransparentAt: aPoint - self fullBounds origin) not]

]

{ #category : #drawing }
IfElseBlockMorph >> drawBottomBarOn: aCanvas [ 

	self drawInnerBottomY: self bottom - CBlockBracketThickness - 4 on: aCanvas.
	self drawBottomEdgeOn: aCanvas.


]

{ #category : #drawing }
IfElseBlockMorph >> drawElseBarOn: aCanvas [

	| left y |
	"these are in absolute coordinates"
	left := self left + CBlockBracketThickness - 1.
	y := self top + elseBarY.

	self drawInnerBottomY: y on: aCanvas.

	y := y + 2.
	aCanvas
		fillRectangle: (left@y corner: (self right - 1)@(y + self elseBarHeight))
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@y corner: self right@(y + self elseBarHeight))
		color: shadowColor.
	self drawInnerTopY: elseBarY + self elseBarHeight + 2 on: aCanvas.

]

{ #category : #drawing }
IfElseBlockMorph >> drawInnerBottomY: y on: aCanvas [

	| left barBottom |
	left := self left + CBlockBracketThickness - 1.
	barBottom := y + (CBlockBracketThickness - 3).

	"fill in bottom-left corner"
	aCanvas fillRectangle: (left@(y - 2) extent: 1@1) color: color.
	aCanvas fillRectangle: (left@(y - 1) extent: 2@1) color: color.
	aCanvas fillRectangle: (left@y extent: 3@1) color: color.

	aCanvas
		fillRectangle: ((left + 3)@y corner: (self right - 2)@(y + 1))
		color: highlightColor1.
	aCanvas
		fillRectangle: (left@(y + 1) corner: (self right - 1)@barBottom)
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@(y + 2) corner: self right@barBottom)
		color: shadowColor.



]

{ #category : #drawing }
IfElseBlockMorph >> drawInnerTopY: y on: aCanvas [

	| left right gapStart gapEnd |
	left := CBlockBracketThickness - 1.
	right := self width - 1.
	gapStart := left + PuzzleInset + 1.
	gapEnd := gapStart + PuzzleWidth.

	self drawHLineFrom: left to: (right - 1) y: y color: color on: aCanvas.
	self drawHLineFrom: left to: (right - 2) y: y + 1 color: color on: aCanvas.

	"fill in upper-left inside corner"
	self drawHLineFrom: left to: (left + 2) y: y + 2 color: color on: aCanvas.
	self drawHLineFrom: left to: (left + 1) y: y + 3 color: color on: aCanvas.
	self drawPoint: (left + 1)@(y + 3) color: shadowColor on: aCanvas.

	self drawHLineFrom: gapStart to: gapEnd y: y + 2 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 1 to: gapEnd - 1 y: y + 3 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 1 to: gapEnd - 1 y: y + 4 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 2 to: gapEnd - 2 y: y + 5 color: color on: aCanvas.

	self drawHLineFrom: (left + 2) to: gapStart y: y + 2 color: shadowColor on: aCanvas.
	self drawHLineFrom: gapEnd to: right - 2 y: y + 2 color: shadowColor on: aCanvas.
	self drawHLineFrom: gapStart + 2 to: gapEnd - 2 y: y + 6 color: shadowColor on: aCanvas.

	self drawPoint: gapStart@(y + 3) color: shadowColor on: aCanvas.
	self drawPoint: gapStart@(y + 4) color: shadowColor on: aCanvas.
	self drawPoint: (gapStart + 1)@(y + 5) color: shadowColor on: aCanvas.

	self drawPoint: (gapEnd - 1)@(y + 3) color: shadowColor on: aCanvas.
	self drawPoint: (gapEnd - 1)@(y + 4) color: shadowColor on: aCanvas.
	self drawPoint: (gapEnd - 2)@(y + 5) color: shadowColor on: aCanvas.

	self drawPoint: (right - 1)@y color: shadowColor on: aCanvas.
	self drawPoint: (right - 2)@(y + 1) color: shadowColor on: aCanvas.


]

{ #category : #drawing }
IfElseBlockMorph >> drawOn: aCanvas [ 

	| c |
	topBarBottom := self top + self topBarHeight.
	blockBottom := self bottom - 7.

	self computeHighlightColors.
	c := FormCanvas extent: self extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self drawTopEdgeOn: c.
	self drawTopBarOn: c.
	self drawVerticalBarOn: c.
	self drawElseBarOn: c.
	self drawBottomBarOn: c.

	self drawFinalOn: aCanvas fromCanvas: c.

]

{ #category : #drawing }
IfElseBlockMorph >> drawTopBarOn: aCanvas [ 

	aCanvas
		fillRectangle: (self left@(self top + 5) corner: (self right - 1)@topBarBottom)
		color: color.
	aCanvas
		fillRectangle: ((self right - 1)@(self top + 3) corner: self right @topBarBottom)
		color: shadowColor.

	self drawInnerTopY: topBarBottom - self top on: aCanvas.


]

{ #category : #drawing }
IfElseBlockMorph >> drawVerticalBarOn: aCanvas [ 

	| left top barRight |
	left := self left.
	barRight := (left + CBlockBracketThickness) - 1.
	top := self top.
	
	aCanvas
		fillRectangle: (left@(top + 5) corner: barRight@blockBottom)
		color: color.
	aCanvas
		fillRectangle: (left@(top + 2) corner: (left + 2)@blockBottom)
		color: highlightColor2.

	aCanvas
		fillRectangle: (barRight@(topBarBottom + 4) corner: (barRight + 1)@blockBottom)
		color: shadowColor.

]

{ #category : #private }
IfElseBlockMorph >> elseBarHeight [
	^ (ScratchTranslator
		stringExtent: 'else' localized
		font: ScratchTranslator labelFont) y
]

{ #category : #'code generation' }
IfElseBlockMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitIfElseBlock: self indent: indent.
]

{ #category : #'code generation' }
IfElseBlockMorph >> falseBlock [
	^ falseBlock
]

{ #category : #private }
IfElseBlockMorph >> falseBlock: aBlockMorph [
	"Add the given block as my false nested block sequence. Delete the old nested blocks, if any."

	falseBlock ifNotNil: [falseBlock delete].
	falseBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].

]

{ #category : #accessing }
IfElseBlockMorph >> falseBlockList [
	"Answer an array containing the block sequence false-case nested stack."

	^ falseBlock ifNil: [ #() ] ifNotNil: [ falseBlock blockSequence ]
]

{ #category : #private }
IfElseBlockMorph >> fixBlockLayout [
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
								centerOffsetForButtonWithFont: ScratchTranslator labelFont)
								// 4))
]

{ #category : #initialization }
IfElseBlockMorph >> initialize [

	super initialize.
	self color: (Color r: 1.0 g: 0.581 b: 0.194).

]

{ #category : #testing }
IfElseBlockMorph >> isIfElseBlock [
	^ true
]

{ #category : #accessing }
IfElseBlockMorph >> nestedBlockAt: aPoint [

	| dist |
	trueBlock
		ifNotNil: [dist := trueBlock - aPoint.
			falseBlock
				ifNotNil: [(dist > (falseBlock - aPoint))
					ifTrue: [^ falseBlock]
					ifFalse: [^ trueBlock]]
				ifNil: [^ trueBlock]]
		ifNil: [^ falseBlock].

]

{ #category : #private }
IfElseBlockMorph >> nextBlock [
	"Answer the block myself in the block sequence or nil if I am the last block in the sequence. Each block is a submorph of the previous block."

	^ nextBlock

]

{ #category : #private }
IfElseBlockMorph >> nextBlock: aBlockMorph [
	"Add the given block as the block following me. Delete old nextBlock, if any."

	self nextBlock ifNotNil: [self nextBlock delete].
	nextBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].

]

{ #category : #private }
IfElseBlockMorph >> nonControlFlowSubmorphs [
	"Answer a collection of submorphs minus any blocks that are part of the control flow. For example, command blocks omit their submorph that is the next block in the block sequence, C-blocks omit both their next block and the first block of their nested block list, etc."

	^ submorphs select: [:m |
		(m ~~ trueBlock) &
		(m ~~ falseBlock) &
		(m ~~ nextBlock)]

]

{ #category : #accessing }
IfElseBlockMorph >> stretchHeight: aNumber [
	"Temporary"

	^ self

]

{ #category : #private }
IfElseBlockMorph >> topBarHeight [
	"Answer the height of the top bar."

	| nonBlockSubmorphs |
	nonBlockSubmorphs := self submorphs select: [:m |
		(m isKindOf: BlockMorph) not or: [argMorphs includes: m]].
	^ nonBlockSubmorphs inject: CBlockBracketThickness into: [:h :m | h max: (m height + 4)].


]

{ #category : #'code generation' }
IfElseBlockMorph >> trueBlock [
	^ trueBlock
]

{ #category : #private }
IfElseBlockMorph >> trueBlock: aBlockMorph [
	"Add the given block as my true nested block sequence. Delete the old nested blocks, if any."

	trueBlock ifNotNil: [trueBlock delete].
	trueBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].

]

{ #category : #accessing }
IfElseBlockMorph >> trueBlockList [
	"Answer an array containing the block sequence true-case nested stack."

	^ trueBlock ifNil: [ #() ] ifNotNil: [ trueBlock blockSequence ]
]
