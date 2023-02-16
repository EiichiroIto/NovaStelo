"
I and my subclasses represent statements in a block-based graphical programming language.

"
Class {
	#name : #BlockMorph,
	#superclass : #Morph,
	#instVars : [
		'isSpecialForm',
		'oldColor',
		'highlightColor1',
		'highlightColor2',
		'shadowColor',
		'scratchProc',
		'hadError',
		'blockLayoutNeeded',
		'cachedForm',
		'cachedFeedbackForm'
	],
	#classVars : [
		'CBlockBracketThickness',
		'LabelColor',
		'PuzzleInset',
		'PuzzleWidth'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #'class initialization' }
BlockMorph class >> initialize [
	"self initialize"

	LabelColor := nil.

	PuzzleInset := 11.
	PuzzleWidth := 14.
	CBlockBracketThickness := 12.

	"DebugMenu := true"
]

{ #category : #accessing }
BlockMorph class >> labelColor [
	^ LabelColor ifNil: [ LabelColor := ScratchTheme labelOffColor ]
]

{ #category : #'dropping/grabbing' }
BlockMorph >> aboutToBeGrabbedBy: aHandMorph [
	"If I'm being used as an argument, replace myself with an appropriate argument morph. Copied from WatcherMorph."

	| m |
	owner ifNil: [ ^ self ].
	owner isCommandBlock
		ifFalse: [ ^ self ].
	"if I was being used as argument, replace myself with a generic argument morph"
	m := owner argMorphToReplace: self.
	m ifNil: [ ^ self ].
	owner replaceArgMorph: self by: m
]

{ #category : #accessing }
BlockMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #accessing }
BlockMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type. Answer false by default."

	^ false

]

{ #category : #accessing }
BlockMorph >> applicationDo: aBlock [
	^ self project ifNotNil: [ :p | aBlock value: p application ]
]

{ #category : #private }
BlockMorph >> attachBlock: aBlockMorph [
	"Attach the given block to me. Assume the block has been positioned correctly."

	self addMorph: aBlockMorph.

]

{ #category : #private }
BlockMorph >> attachBlockNested: aBlockMorph [
	self shouldNotImplement
]

{ #category : #private }
BlockMorph >> blockAttachPoints: aSet [
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping command block could be attached."

	| nextB result |
	result := #().
	self isHatBlock
		ifFalse: [ result := result copyWith: self topLeft -> self ].
	nextB := self nextBlock.
	nextB
		ifNil: [ self isStopOrForever
				ifFalse: [ result := result copyWith: self bottomLeft -> self ] ].
	nextB ifNotNil: [ nextB blockAttachPoints: aSet ].
	aSet addAll: result
]

{ #category : #accessing }
BlockMorph >> blockPalette [
	owner ifNil: [ ^ nil ].
	owner isBlockPalette ifTrue: [ ^ owner ].
	owner isScriptEditor ifTrue: [ ^ nil ].
	^ owner blockPalette
]

{ #category : #'block enumerating' }
BlockMorph >> blockSequence [
	"Answer the sequence of blocks starting with myself. Each block is a submorph of the previous block."

	| stream this |
	stream := WriteStream on: Array new.
	this := self.
	[ this isNil ]
		whileFalse: [ stream nextPut: this.
			this := this nextBlock ].
	^ stream contents
]

{ #category : #'block enumerating' }
BlockMorph >> bottomBlock [
	"Answer the bottom Block of this stack. The top block may be a CommandBlockMorph, or perhaps some other kind of BlockMorph."

	| m obj |
	m := self.
	[ obj := m nextBlock.
	obj ifNil: [ ^ m ].
	obj isBlockMorph ] whileTrue: [ m := m nextBlock ].
	^ m
]

{ #category : #accessing }
BlockMorph >> bracketThickness [
	self shouldNotImplement
]

{ #category : #accessing }
BlockMorph >> canBecomeWatcher [
	"Answer true if this block can become a watcher when dropped onto the stage. False by default."

	^ false

]

{ #category : #'drawing-optimization' }
BlockMorph >> changed [
	"Don't flush my cachedForm when I do 'self changed'."

	owner ifNotNil: [owner invalidRect: (self fullBounds expandBy: 3)].

]

{ #category : #processes }
BlockMorph >> clearProcess [
	"Called on the top block of a running stack when all processes are stopped."

	scratchProc ifNotNil: [self scratchProc: nil].

]

{ #category : #accessing }
BlockMorph >> closestAttachTargetIn: newOwner [
	"Answer the closest block attachment point among the blocks and stack submorphs of the given morph. Answer nil if there are no blocks close enough to attach myself to."

	| xThresh yThresh attachPoints best bestDist targetP dist ref topUsed bottomUsed |
	xThresh := 65.
	yThresh := (self isCBlock
		and: [ (self nestedBlockAt: self top + self topBarHeight) isNil ])
		ifTrue: [ 25 ]
		ifFalse: [ 14 ].
	topUsed := false.
	bottomUsed := false.
	attachPoints := OrderedCollection new: 100.
	newOwner
		submorphsDo: [ :m | 
			(m ~~ self
				and: [ m ~~ self bottomBlock
						and: [ m ~~ self topBlock
								and: [ m ~~ self owner and: [ m isBlockMorph and: [ m isReporter not ] ] ] ] ])
				ifTrue: [ m blockAttachPoints: attachPoints ] ].
	(self isHatBlock
		or: [ (self meOrOwnerThatIsA: HatBlockMorph) notNil ])
		ifTrue:
			[ "if I am a HatBlock or the bottom block of a HatBlock stack, I can only attach to the top block of a stack"
			attachPoints := attachPoints
				select:
					[ :assoc | assoc value owner = newOwner and: [ assoc key y = assoc value top ] ] ].
	(self isStop or: [ self bottomBlock isStop ])
		ifTrue: [ "I am a stop block; I can't attach to the top of a stack"
			attachPoints := attachPoints
				select: [ :assoc | assoc key y ~= assoc value top ] ].
	(self topBlock isForever not and: [ self bottomBlock isForever ])
		ifTrue: [ "My bottom block is a forever; I can't attach to the top of a stack"
			attachPoints := attachPoints
				select: [ :assoc | assoc key y ~= assoc value top ] ].
	best := nil.
	bestDist := 10000.
	attachPoints
		do: [ :assoc | 
			targetP := assoc key.
			ref := self left.
			(ref - targetP x) abs < xThresh
				ifTrue: [ ((self top - targetP y) abs < yThresh
						or: [ self nextBlock isNil
								and: [ (self bottom - targetP y) abs < yThresh ] ])
						ifTrue: [ "targetP is within sticking range"
							dist := (self position - targetP) r.
							dist < bestDist
								ifTrue: [ (self top - targetP y) abs < yThresh
										ifTrue: [ topUsed := true.
											bottomUsed := false ].
									(self nextBlock isNil
										and: [ (self bottom - targetP y) abs < yThresh ])
										ifTrue: [ topUsed := false.
											bottomUsed := true ].
									best := assoc.
									bestDist := dist ] ] ] ].

	"special case for the auto-wrapping of c-shaped/if-else blocks"
	self isCBlock
		ifTrue: [ best
				ifNotNil: [ bottomUsed
						ifTrue: [ best value owner isBlockMorph
								ifTrue: [ self stretchHeight: 0.
									^ best := nil ] ].
					(self isStopOrForever or: [ self bottomBlock isStopOrForever ])
						ifTrue: [ bottomUsed
								ifTrue: [ self stretchHeight: 0.
									^ best := nil ] ].
					(best key y = best value top
						and: [ (self isForever or: [ self bottomBlock isForever ])
								and: [ (self nestedBlockAt: best key y) isNil not ] ])
						ifTrue: [ self stretchHeight: 0.
							^ best := nil ].
					(self nestedBlockAt: best key y)
						ifNil: [ bottomUsed
								ifTrue: [ self stretchHeight: 0.
									best key y = best value bottom
										ifTrue: [ ^ best := nil ].
									(best key y = best value top
										and: [ best value owner isBlockMorph ])
										ifTrue: [ ^ best := nil ].
									(best key y = best value bottom
										and: [ best value owner isBlockMorph not ])
										ifTrue: [ ^ best := nil ] ].
							topUsed
								ifTrue: [ (best key y = best value bottom
										and: [ best value nextBlock isNil not ])
										ifTrue: [ self stretchHeight: 0.
											^ best := nil ].
									"((best key y = best value top) and: [(best value owner isKindOf: BlockMorph)]) ifTrue: [self stretchHeight: 0. ^ best := nil]."
									best key y = best value top
										ifTrue: [ self stretchHeight: best value fullBounds height - 17.
											^ best ] ].
							self stretchHeight: 0 ] ].
			best ifNil: [ self stretchHeight: 0 ] ].
	^ best
]

{ #category : #accessing }
BlockMorph >> color: aColor [
	"Remember the color of this block, for lighting-up purposes."

	super color: aColor.
	oldColor := aColor.
]

{ #category : #drawing }
BlockMorph >> computeHighlightColors [

	| h s v |
	h := color hue.
	s := color saturation.
	v := color brightness.
	highlightColor1 := Color h: h s: (s - 0.13) v: (v + 0.1).
	highlightColor2 := Color h: h s: s v: (v + 0.07).
	shadowColor := color mixed: 0.7 with: Color black.

]

{ #category : #private }
BlockMorph >> copyRecordingIn: aDict [

		^ (super copyRecordingIn: aDict) clearProcess.
	
]

{ #category : #'event handling' }
BlockMorph >> delete [
	self topBlock stopProcess.
	super delete

]

{ #category : #'event handling' }
BlockMorph >> doubleClick: evt [
	"If I'm a block with a receiver that's in a Scratch window, execute me."

	self topBlock toggleProcess.

]

{ #category : #drawing }
BlockMorph >> drawBodyOn: aCanvas [ 

	aCanvas
		fillRectangle: (self left@(self top + 5) corner: (self right - 1)@(self bottom - 7))
		color: color.
	aCanvas
		fillRectangle: (self left@(self top + 2) corner: (self left + 2)@(self bottom - 7))
		color: highlightColor2.

	aCanvas
		fillRectangle: ((self right - 1)@(self top + 3) corner: self right@(self bottom - 7))
		color: shadowColor.

]

{ #category : #drawing }
BlockMorph >> drawBottomEdgeOn: aCanvas [

	| right y gapStart gapEnd |
	right := self width - 1.
	y := self height - 7.
	gapStart := PuzzleInset.
	gapEnd := PuzzleInset + PuzzleWidth.

	self drawHLineFrom: 1 to: right - 1 y: y color: color on: aCanvas.
	self drawHLineFrom: 2 to: right - 2 y: y + 1 color: color on: aCanvas.

	self drawHLineFrom: gapStart to: gapEnd y: y + 2 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 1 to: gapEnd - 1 y: y + 3 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 1 to: gapEnd - 1 y: y + 4 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 2 to: gapEnd - 2 y: y + 5 color: color on: aCanvas.

	self drawHLineFrom: 3 to: gapStart y: y + 2 color: shadowColor on: aCanvas.
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
BlockMorph >> drawFinalOn: aCanvas fromCanvas: c [
	aCanvas paintImage: c form at: self topLeft
]

{ #category : #drawing }
BlockMorph >> drawHLineFrom: startX to: endX y: yOffset color: c on: aCanvas [

	| y |
	y := self top + yOffset.
	aCanvas
		fillRectangle: ((self left + startX)@y corner: (self left + endX)@(y + 1))
		color: c.

]

{ #category : #drawing }
BlockMorph >> drawOn: aCanvas [ 

	| c |
	self computeHighlightColors.
	c := FormCanvas extent: self extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self isReporter ifTrue: [
		self drawSmoothTopEdgeOn: c.
		self drawReporterBodyOn: c.
		self drawSmoothBottomEdgeOn: c.
		^ self].

	self isStop ifTrue: [
		self drawTopEdgeOn: c.
		self drawStopBodyOn: c.
		self drawSmoothBottomEdgeOn: c.
		self drawFinalOn: aCanvas fromCanvas: c.
		^ self].

	self drawTopEdgeOn: c.
	self drawBodyOn: c.
	self drawBottomEdgeOn: c.

	self drawFinalOn: aCanvas fromCanvas: c.

]

{ #category : #drawing }
BlockMorph >> drawPoint: aPoint color: c on: aCanvas [

	aCanvas fillRectangle: (self topLeft + aPoint extent: (1@1)) color: c.

]

{ #category : #drawing }
BlockMorph >> drawReporterBodyOn: aCanvas [ 

	aCanvas
		fillRectangle: (self left@(self top + 3) corner: (self right - 1)@(self bottom - 3))
		color: color.
	aCanvas
		fillRectangle: (self left@(self top + 2) corner: (self left + 2)@(self bottom - 3))
		color: highlightColor2.

	aCanvas
		fillRectangle: ((self right - 1)@(self top + 2) corner: self right@(self bottom - 3))
		color: shadowColor.

]

{ #category : #drawing }
BlockMorph >> drawSmoothBottomEdgeOn: aCanvas [

	| right y |
	right := self width - 1.
	y := self height - 3.

	self drawHLineFrom: 1 to: right - 1 y: y color: color on: aCanvas.
	self drawHLineFrom: 2 to: right - 2 y: y + 1 color: color on: aCanvas.
	self drawHLineFrom: 3 to: right - 2 y: y + 2 color: shadowColor on: aCanvas.

	self drawPoint: (right - 1)@y color: shadowColor on: aCanvas.
	self drawPoint: (right - 2)@(y + 1) color: shadowColor on: aCanvas.

]

{ #category : #drawing }
BlockMorph >> drawSmoothTopEdgeOn: aCanvas [

	| right |
	right := self width - 1.

	self drawHLineFrom: 2 to: right - 2 y: 0 color: highlightColor1 on: aCanvas.
	self drawHLineFrom: 1 to: right - 1 y: 1 color: highlightColor2 on: aCanvas.
	self drawHLineFrom: 0 to: right y: 2 color: color on: aCanvas.

]

{ #category : #drawing }
BlockMorph >> drawStopBodyOn: aCanvas [ 

	aCanvas
		fillRectangle: (self left@(self top + 5) corner: (self right - 1)@(self bottom - 3))
		color: color.

	aCanvas
		fillRectangle: (self left@(self top + 2) corner: (self left + 2)@(self bottom - 3))
		color: highlightColor2.

	aCanvas
		fillRectangle: ((self right - 1)@(self top + 2) corner: self right@(self bottom - 3))
		color: shadowColor.

]

{ #category : #drawing }
BlockMorph >> drawTopEdgeOn: aCanvas [

	| right gapStart gapEnd |
	right := self width - 1.
	gapStart := PuzzleInset.
	gapEnd := PuzzleInset + PuzzleWidth.

	self drawHLineFrom: 2 to: gapStart y: 0 color: highlightColor1 on: aCanvas.
	self drawHLineFrom: gapEnd to: right - 2 y: 0 color: highlightColor1 on: aCanvas.

	self drawHLineFrom: 1 to: gapStart y: 1 color: highlightColor2 on: aCanvas.
	self drawHLineFrom: gapEnd to: right - 1 y: 1 color: highlightColor2 on: aCanvas.

	self drawHLineFrom: 0 to: gapStart + 1 y: 2 color: color on: aCanvas.
	self drawHLineFrom: gapEnd - 1 to: right y: 2 color: color on: aCanvas.

	self drawHLineFrom: 0 to: gapStart + 2 y: 3 color: color on: aCanvas.
	self drawHLineFrom: gapEnd - 2 to: right y: 3 color: color on: aCanvas.

	self drawHLineFrom: 0 to: right y: 4 color: color on: aCanvas.
	self drawHLineFrom: gapStart + 2 to: gapEnd - 2 y: 4 color: highlightColor1 on: aCanvas.

]

{ #category : #'event handling' }
BlockMorph >> duplicate [

	"self world activeHand attachMorph: self fullCopy."
	self world activeHand attachMorph: super duplicate.

]

{ #category : #'code generation' }
BlockMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitBlock: self indent: indent.
]

{ #category : #'block enumerating' }
BlockMorph >> firstBlockList [
	"If I am a control block, answer an array containing the block sequences for my first nested block (i.e., the blocks for the 'true' case of an if-then-else block). If I'm not a control structure block, just answer an empty array."

	^ #()

]

{ #category : #private }
BlockMorph >> fixBlockLayout [
	"This default implementation just clears my cached forms."

	blockLayoutNeeded ifFalse: [^ self].
	cachedForm := nil.
	cachedFeedbackForm := nil.

]

{ #category : #'drawing-optimization' }
BlockMorph >> fullBounds [
	"This is the hook that triggers lazy re-layout. It works because layoutChanged clears the fullBounds cache. Once per cycle, the fullBounds is requested from every morph in the world, and that request gets propagated through the entire submorph hierarchy, causing re-layout where needed. Note that multiple layoutChanges to the same morph can be done with little cost, since the layout is only done when the morph needs to be displayed."
	"Detail: Expands by 3 pixels if I have a process to allow for the running/error feedback."

	fullBounds ifNil: [
		"do layout here"
		blockLayoutNeeded ifTrue: [
			super fullBounds.
			self fixBlockLayout.
			fullBounds := nil.
			super fullBounds.  "recompute after layout"
			self changed].
		blockLayoutNeeded := false].

	scratchProc ifNotNil: [^ super fullBounds expandBy: 3].  "allow for running/error feedback"

	^ super fullBounds

]

{ #category : #'drawing-optimization' }
BlockMorph >> fullDrawOn: aCanvas [
	"Optimization: To speed up redisplay, especially when giving feedback that a stack is running, we create a cached form of the stack in the top block of the stack and simply display that. We also keep a cached image of the running/error feedback outline. This allows the running feedback to be turned on and off quickly. The caches are flushed whenever the layout of the stack changes."

	| offset |
	self visible ifFalse: [^ self].
	(self hasProperty: #errorOnDraw) ifTrue:[^ self drawErrorOn: aCanvas].
	(owner isBlockMorph) ifTrue: [^ super fullDrawOn: aCanvas].  "only cache at top level"

	cachedForm ifNil: [self updateCachedForm].
	cachedForm ifNil: [^ super fullDrawOn: aCanvas].  "should not happen"

	offset := 0@0.
	scratchProc ifNotNil: [
		offset := 3@3.
		cachedFeedbackForm ifNil: [self updateCachedFeedbackForm].
		cachedFeedbackForm ifNotNil: [
			aCanvas paintImage: cachedFeedbackForm at: self fullBounds topLeft]].

	aCanvas paintImage: cachedForm at: self fullBounds topLeft + offset.

]

{ #category : #'dropping/grabbing' }
BlockMorph >> handleReporterDrop [
	"This block, a reporter, has just been dropped. Try to embed it in a command block."

	| scriptsMorph argM argOwner |
	(self isReporter and: [ owner isScriptEditor ])
		ifFalse: [ ^ self ].
	scriptsMorph := owner.
	argM := owner topArgMorphAt: self bounds exclude: self.
	(argM notNil and: [ argM acceptsTypeOf: self ])
		ifFalse: [ ^ self ].
	argM isBlockMorph
		ifTrue: [ argOwner := argM owner.
			argOwner replaceArgMorph: argM by: self.
			scriptsMorph addMorph: argM.
			argM position: (argOwner left + 90) @ (argM top - 20) ]
		ifFalse: [ argM owner replaceArgMorph: argM by: self ]
]

{ #category : #'event handling' }
BlockMorph >> handlesMouseDown: evt [

	^ true

]

{ #category : #initialization }
BlockMorph >> initialize [

	super initialize.
	blockLayoutNeeded := true.
	isSpecialForm := false.
	color := Color r: 0.4 g: 0.7 b: 0.8.
	oldColor := color.
	hadError := false
]

{ #category : #'drawing-optimization' }
BlockMorph >> invalidRect: damageRect [
	"Flush my cachedForm if some submorph reports a change."

	super invalidRect: (damageRect expandBy: 3).  "allows for running feedback"
	cachedForm := nil.

]

{ #category : #testing }
BlockMorph >> isBlockMorph [
	"True only for BlockMorphs."

	^ true

]

{ #category : #testing }
BlockMorph >> isBooleanReporter [
	"Answer true if this block reports a boolean value. Answer false by default."

	^ false

]

{ #category : #testing }
BlockMorph >> isCBlock [
	^ false
]

{ #category : #testing }
BlockMorph >> isChoiceArg [

	^ false
]

{ #category : #testing }
BlockMorph >> isForever [
	"True only for forever command blocks."

	^ false

]

{ #category : #testing }
BlockMorph >> isHatBlock [

	^ false

]

{ #category : #testing }
BlockMorph >> isIfElseBlock [
	^ false
]

{ #category : #testing }
BlockMorph >> isInBlockPalette [
	owner ifNil: [ ^ false ].
	owner isBlockPalette ifTrue: [ ^ true ].
	owner isScriptEditor ifTrue: [ ^ false ].
	^ owner isInBlockPalette
]

{ #category : #testing }
BlockMorph >> isInScriptEditor [
	owner ifNil: [ ^ false ].
	owner isBlockPalette ifTrue: [ ^ false ].
	owner isScriptEditor ifTrue: [ ^ true ].
	^ owner isInScriptEditor
]

{ #category : #testing }
BlockMorph >> isReporter [
	"Answer true if this block reports a value. False by default."

	^ false

]

{ #category : #testing }
BlockMorph >> isSetterBlock [

	^ false
]

{ #category : #testing }
BlockMorph >> isSpecialForm [

	^isSpecialForm.
]

{ #category : #testing }
BlockMorph >> isSpecialForm: aBoolean [
	"Sets a flag indicating that this block has a special evaluation rule."

	isSpecialForm := aBoolean.
]

{ #category : #testing }
BlockMorph >> isStop [
	"True for only stop command blocks."

	^ false

]

{ #category : #testing }
BlockMorph >> isStopOrForever [
	"True for stop or forever command blocks."

	^ self isStop or: [self isForever]

]

{ #category : #testing }
BlockMorph >> isVariableBlock [
	"do not delete"
	^ false
]

{ #category : #'dropping/grabbing' }
BlockMorph >> justDroppedInto: newOwner event: evt [
	"Handle being dropped into a new situation."

	| project targetAssoc targetP targetBlock bottomBlockUsed upperBlock |
	bottomBlockUsed := false.

	"blocks cannot be dropped onto the stage"
	owner isWorldMorph
		ifTrue: [ self delete.
			self receiver blocksBin changed.
			^ self ].
	(project := newOwner project) ifNotNil: [ project modified: true ].
	"delete myself when dropped in the blocks palette area"
	self isInBlockPalette
		ifTrue: [ self delete.
			self receiver blocksBin changed.
			^ self ].
	"okay to drop blocks into the world during development"
	"((owner == World) and: [Preferences noviceMode not]) ifTrue: [^ self]."
	(owner isScriptEditor
		or: [ owner isBlockMorph or: [ self isReporter ] ])
		ifFalse: [ ^ self rejectDropEvent: evt ].
	self isReporter
		ifTrue: [ ^ self handleReporterDrop ].
	targetAssoc := self closestAttachTargetIn: newOwner.
	targetAssoc
		ifNil: [ self bottomBlock isCBlock
				ifFalse: [ targetAssoc := self bottomBlock closestAttachTargetIn: newOwner.
					targetAssoc
						ifNotNil: [ bottomBlockUsed := true.
							targetAssoc value owner isBlockMorph
								ifTrue: [ targetAssoc := nil ] ] ] ].
	targetAssoc ifNil: [ ^ self ].

	"make sure no processes are running"
	self = self topBlock
		ifTrue: [ self stopProcess ].
	targetP := targetAssoc key.
	targetBlock := targetAssoc value.
	targetP y = targetBlock top
		ifTrue: [ "c-shaped block should nest the target block"
			"((bottomBlockUsed not) and: [((targetBlock owner isKindOf: BlockMorph) not) and: [(self isKindOf: CBlockMorph)]]) ifTrue:["
			(bottomBlockUsed not and: [ self isCBlock ])
				ifTrue: [ targetBlock owner isBlockMorph
						ifTrue: [ targetBlock owner attachBlock: self ]
						ifFalse: [ self
								position:
									(targetP x - self bracketThickness)
										@ (targetP y - self topBarHeight - 3) ].
					self attachBlockNested: targetBlock.
					^ self ].
			"for all other non-c-shaped blocks"
			(bottomBlockUsed
				or: [ targetBlock owner isBlockMorph not and: [ self isCBlock not ] ])
				ifTrue: [ self bottomBlock
						position: targetP x @ (targetP y - (self bottomBlock height - 4)).
					upperBlock := self bottomBlock owner.
					[ upperBlock isBlockMorph ]
						whileTrue: [ upperBlock nextBlock
								ifNotNil: [ upperBlock
										position:
											targetP x
												@ (upperBlock nextBlock position y - (upperBlock height - 4)).
									upperBlock := upperBlock owner ] ] ].
			(bottomBlockUsed not and: [ targetBlock owner isBlockMorph ])
				ifTrue: [ self position: targetP x @ (targetP y - (self height - 4)) ].
			targetBlock owner isBlockMorph
				ifTrue: [ self topBlock position: targetP x @ targetP y.
					targetBlock owner attachBlock: self topBlock ].
			targetBlock
				position:
					targetP x
						@ (self bottomBlock position y + self bottomBlock height + 4).
			(bottomBlockUsed not
				and: [ targetBlock owner isBlockMorph not and: [ self isCBlock ] ])
				ifFalse: [ self bottomBlock attachBlock: targetBlock ] ]
		ifFalse: [ self assert: [ self isHatBlock not ].	"I am not a HatBlockMorph"
			self position: targetP.
			targetBlock attachBlock: self ]
]

{ #category : #private }
BlockMorph >> labelColor [
	"Answer a label color, either black or white, that maximizes the contrast with my color."

	^ self class labelColor

"old:
	^ self color luminance > 0.8
		ifTrue: [Color black]
		ifFalse: [Color white]
"

]

{ #category : #private }
BlockMorph >> layoutChanged [

	blockLayoutNeeded ifFalse: [super layoutChanged].
	blockLayoutNeeded := true.


]

{ #category : #accessing }
BlockMorph >> litUp: aBoolean [
	"If the argument true, light up this block. Otherwise, revert to it's old color."

	"Note: We use super color: so we don't overwrite oldColor. We also force a world update to ensure that the highlighting is seen by the user."

	aBoolean
		ifTrue: [ super color: (Color h: 60 s: 0.9 v: 0.89) ]
		ifFalse: [ oldColor ifNotNil: [ super color: oldColor ] ]
]

{ #category : #'event handling' }
BlockMorph >> mouseDown: evt [
	"Handle a mouse click. Left button either drags or performs click action. Right button brings up a menu."

	evt hand newKeyboardFocus: nil.
	evt yellowButtonPressed
		ifTrue: [ "Sensor waitNoButton."
			^ self rightButtonMenu: evt ].
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #accessing }
BlockMorph >> nestedBlockAt: aPoint [
	^ nil
]

{ #category : #'block enumerating' }
BlockMorph >> nextBlock [
	"Answer the block myself in the block sequence or nil if I am the last block in the sequence. Each block is a submorph of the previous block."

	^ self submorphs detect: [:m | m isBlockMorph] ifNone: [nil]

]

{ #category : #'block enumerating' }
BlockMorph >> nextBlock: aBlockMorph [
	"Add the given block to this stack."

	self addMorph: aBlockMorph.

]

{ #category : #'block enumerating' }
BlockMorph >> nextOrInnerBlocks [

	^ self nextBlock
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :block | Array with: block ]
]

{ #category : #private }
BlockMorph >> nonControlFlowSubmorphs [
	"Answer a collection of submorphs minus any blocks that are part of the control flow. For example, command blocks omit their submorph that is the next block in the block sequence, C-blocks omit both their next block and the first block of their nested block list, etc."

	^ submorphs select: [:m | (m ~~ self nextBlock)]

]

{ #category : #'code generation' }
BlockMorph >> parseUsing: aParser [
	^ aParser parseBlock: self
]

{ #category : #accessing }
BlockMorph >> project [
	^ owner ifNotNil: [ owner project ]
]

{ #category : #accessing }
BlockMorph >> receiver [
	"Overridden by blocks which have receivers."

	^ nil

]

{ #category : #accessing }
BlockMorph >> receiver: anObject [
	"Set my receiver. Does nothing here, but overridden in blocks that have a receiver." 

]

{ #category : #'dropping/grabbing' }
BlockMorph >> rejectDropEvent: evt [
	"Reject being dropped by the given event."

	evt hand rejectDropMorph: self event: evt.
]

{ #category : #'event handling' }
BlockMorph >> rightButtonMenu: anEvent [
	self showMenu: anEvent
]

{ #category : #'dropping/grabbing' }
BlockMorph >> rootForGrabOf: aMorph [
	"Allow myself to be extracted."

	^ (owner notNil and: [ owner isBlockPalette ])
		ifTrue: [ super rootForGrabOf: aMorph ]
		ifFalse: [ self ]
]

{ #category : #processes }
BlockMorph >> scratchProc [
	"Answer my process or nil if I'm not currently the top of a running stack."

	^ scratchProc

]

{ #category : #processes }
BlockMorph >> scratchProc: aScratchProcess [

	hadError ifTrue: [ cachedFeedbackForm := nil ].
	hadError := false.
	scratchProc := aScratchProcess.
	self changed
]

{ #category : #processes }
BlockMorph >> showError [
	"Make this block to show an error."

	super color: (Color r: 0.831 g: 0.156 b: 0.156)
]

{ #category : #processes }
BlockMorph >> showErrorFeedback [
	"Show that this stack encountered an error."

	hadError := true.
	cachedFeedbackForm := nil.
	self changed
]

{ #category : #private }
BlockMorph >> showMenu: anEvent [
	self project ifNotNil: [ :p | p application showBlockMenu: self event: anEvent ]
]

{ #category : #'dropping/grabbing' }
BlockMorph >> slideBackToFormerSituation: evt [

	| wasEmbedded o pane oldP slideForm startPoint |
	wasEmbedded := false.
	(o := evt hand formerOwner) ifNil: [^ self].
	(o isKindOf: BlockMorph) ifTrue: [
		wasEmbedded := true.
		(pane := o meOrOwnerThatIsA: ScratchScriptsMorph) ifNotNil: [
			o := pane]].
	oldP := evt hand formerPosition.
	slideForm := self imageForm offset: 0@0.
	startPoint := evt hand fullBounds origin.
	owner privateRemoveMorph: self.
	self world displayWorld.
	slideForm slideFrom: startPoint to: oldP nSteps: 12 delay: 15.
	self position: oldP.
	o addMorph: self.
	wasEmbedded ifTrue: [self justDroppedInto: o event: evt].


]

{ #category : #'event handling' }
BlockMorph >> startDrag: evt [
	| rootForGrab point |
	point := evt hand firstClickCursorPoint ifNil: [ evt cursorPoint ].
	rootForGrab := self rootForGrabOf: self.
	rootForGrab ifNil: [ ^ self ].
	evt hand grabMorph: rootForGrab.
	rootForGrab
		position: evt hand position + (rootForGrab topLeft - point)
]

{ #category : #processes }
BlockMorph >> startProcess [
	"Start a process running this block stack. This default implementation does nothing."

]

{ #category : #processes }
BlockMorph >> stop [
	scratchProc
		ifNotNil: [ self changed.
			scratchProc stop.
			scratchProc := nil ]
]

{ #category : #processes }
BlockMorph >> stopProcess [
	self applicationDo: [ :app | app stopAllProcesses ]
]

{ #category : #geometry }
BlockMorph >> stretchHeight: aNumber [
	self shouldNotImplement
]

{ #category : #processes }
BlockMorph >> toggleProcess [
	self
		applicationDo: [ :app | 
			app isProcessRunning
				ifTrue: [ self stopProcess ]
				ifFalse: [ self startProcess ] ]
]

{ #category : #private }
BlockMorph >> topBarHeight [
	self shouldNotImplement
]

{ #category : #'block enumerating' }
BlockMorph >> topBlock [
	"Answer the top Block of this stack. The top block may be a HatBlockMorph, a CommandBlockMorph, or perhaps some other kind of BlockMorph."

	| m |
	m := self.
	[ m owner notNil and: [ m owner isBlockMorph ] ]
		whileTrue: [ m := m owner ].
	^ m
]

{ #category : #'block enumerating' }
BlockMorph >> tupleSequence [
	"Answer a sequence of tuples (Array) describing this stack of blocks."

	^ self blockSequence collect: [:b | b asBlockTuple]

]

{ #category : #'drawing-optimization' }
BlockMorph >> updateCachedFeedbackForm [
	"Create a cached feedback Form to show this stack's running (or error) status."

	| outlineColor |
	cachedForm ifNil: [^ self].
	outlineColor := (scratchProc notNil and: [scratchProc errorFlag])
		ifTrue: [Color r: 0.831 g: 0.156 b: 0.156]
		ifFalse: [Color gray: 0.953].

	cachedFeedbackForm := cachedForm
		outlineWidth: 3
		color: outlineColor
		depth: 8.

]

{ #category : #'drawing-optimization' }
BlockMorph >> updateCachedForm [
	"Create a cached Form of this stack's appearance."

	| c |
	oldColor ifNotNil: [ color := oldColor ].
	c := FormCanvas extent: self fullBounds extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self drawOn: c.
	self drawSubmorphsOn: c.
	cachedForm := c form
]

{ #category : #'event handling' }
BlockMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]
