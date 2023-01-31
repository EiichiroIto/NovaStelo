"
I represent a command or reporter. I have a label and may also have one or more arguments. The label text, number of arguments, and ordering of arguments and keywords are defined by my commandSpec string. This string consists of a sequence of keywords interspersed with argument specifications that indicate where the arguments appear. Here are some possible argument specifications:

	%b	- boolean
	%c	- color
	%C	- color (chosen with eyedropper, not palette)
	%m	- morph reference
	%n	- number
	%s	- string

Examples:

	%b and %b
	%m's color %C sees %C
	repeat %n times

"
Class {
	#name : #CommandBlockMorph,
	#superclass : #BlockMorph,
	#instVars : [
		'commandSpec',
		'argPermutation',
		'argMorphs',
		'receiver',
		'selector',
		'isTimed',
		'numberArgFlags',
		'labelId'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #utilities }
CommandBlockMorph class >> argPermutationForSpec: spec withTranslation: translatedSpec [
	"CommandBlockMorph argPermutationForSpec: '%a of %m of %m of %t' withTranslation: '%a de %m de %m de %t'"
	"CommandBlockMorph argPermutationForSpec: '%a of %m of %m of %t' withTranslation: '%t de %m2 de %m1 de %a'"

	| parsedSpec parsedTranslatedSpec parsedSpecArgs parsedTranslatedSpecArgs permutation a copiesSize n originalPermutation |

	parsedSpec := CommandBlockMorph parseCommandSpec: spec.
	parsedSpecArgs := parsedSpec select: [:s | CommandBlockMorph isArgSpec: s].
	parsedTranslatedSpec := CommandBlockMorph parseCommandSpec: translatedSpec.
	parsedTranslatedSpecArgs := parsedTranslatedSpec select: [:s | CommandBlockMorph isArgSpec: s].

	permutation := #().
	1 to: parsedSpecArgs size do: [:i | permutation := permutation copyWith: i].
	originalPermutation := permutation.

	"no change"
	(parsedSpecArgs = parsedTranslatedSpecArgs) ifTrue: [
			^ originalPermutation].

	"otherwise, calculate permutation"
	1 to: parsedSpecArgs size do: [:i |
		a := parsedSpecArgs at: i.
		copiesSize := (parsedSpecArgs select: [:s | (s = a)]) size.
		(copiesSize = 1)
			ifTrue:[permutation at: i put: (parsedTranslatedSpecArgs indexOf: a
				ifAbsent: [Transcript show: 'Permutation failed: ', spec.
						^ originalPermutation])]
			ifFalse:["count copies until now"
				n := ((parsedSpecArgs copyFrom: 1 to: i) select: [:s | (s = a)]) size.
				permutation at: i put: (parsedTranslatedSpecArgs indexOf: (a,n asString)
					ifAbsent: [Transcript show: 'Permutation failed: ', spec.
						^ originalPermutation])]].
	^ permutation

]

{ #category : #utilities }
CommandBlockMorph class >> isArgSpec: aString [
	"Answer true if the given string is an argument specification."

	^ ((aString size > 1) and: [aString first = $%])

]

{ #category : #utilities }
CommandBlockMorph class >> parseCommandSpec: aCommandSpec [
	"Answer an array of token strings containing my keywords and argument specs."

	| result len i j spec k |
	result := OrderedCollection new.
	spec := aCommandSpec.
	"(spec isKindOf: UTF8) ifTrue: [spec := String withAll: spec]."
	len := aCommandSpec size.

	i := 1.
	[(i < len) and: [(spec at: i) isSeparator]] whileTrue: [i := i + 1].
	[i <= len] whileTrue: [
		j := spec indexOf: $% startingAt: i.
		j > 0
			ifTrue: [
				j > i ifTrue: [result addLast: (spec copyFrom: i to: j - 1)].
				j < len
					ifTrue: [k := j + 1.
						((spec at: k) isLetter)
							ifTrue: [[(k+1 <= len) and: [(spec at: k+1) isDigit]] whileTrue:[
								k := k + 1].
								(k >= len)
									ifTrue: [result addLast: (spec copyFrom: j to: len).
										i := len + 1]
									ifFalse: [result addLast: (spec copyFrom: j to: k).
										i := k+1]]
							ifFalse: [result addLast: '%'.
										i := j + 1]]
					ifFalse: [result addLast: '%'.
						i := j + 2]]
			ifFalse: [
				result addLast: (spec copyFrom: i to: len).
				i := len + 1]].

	result := result select: [:s | s ~= ' '].
	^ result asArray collect: [:s | s trimBoth]

]

{ #category : #private }
CommandBlockMorph >> addCommandIcons [
	"Add additional icons to certain blocks. Do nothing if this isn't one of those blocks."

	| f m |
	#turnLeft: = selector
		ifTrue: [ f := ScratchTheme formAt: #turnCCW.
			m := self firstSubmorph delete.
			self addMorphFront: (ImageMorph new form: f).
			self addMorphFront: m.
			^ self ].
	#turnRight: = selector
		ifTrue: [ f := ScratchTheme formAt: #turnCW.
			m := self firstSubmorph delete.
			self addMorphFront: (ImageMorph new form: f).
			self addMorphFront: m.
			^ self ].
	#stopAll = selector
		ifTrue: [ f := ScratchTheme formAt: #stopButton.
			self addMorphBack: (ImageMorph new form: f).
			^ self ]
]

{ #category : #private }
CommandBlockMorph >> addLabel [
	"Add a label for my command and arguments. This is the method that really creates the whole block."

	"Details: We remove all the pieces of this block, and then reassemble them, being careful not to destroy any argument morphs that we might still want to use. This is helpful if someone adds/removes parameters from a hat block."

	| tokens args nextArgIndex m next |
	commandSpec ifNil: [ ^ self ].

	"we make sure not to remove the next block."
	next := self nextBlock.
	self removeAllMorphsIn: (self submorphs reject: [ :t | t = next ]).
	tokens := self class parseCommandSpec: commandSpec.
	args := tokens select: [ :s | self class isArgSpec: s ].

	"remove any excess arg morphs from the list."
	[ argMorphs size > args size ]
		whileTrue: [ m := argMorphs last.
			argMorphs remove: m.

			"if the argument we're throwing out is anything complicated, we'd like to keep it around in the world."
			m isBlockMorph
				ifTrue: [ m openInWorld ] ].

	"create new arg morphs."
	[ argMorphs size < args size ]
		whileTrue:
			[ argMorphs addLast: (self argMorphFor: (args at: argMorphs size + 1)) ].
	nextArgIndex := 1.
	tokens
		do: [ :s | 
			(self class isArgSpec: s)
				ifTrue: [ m := argMorphs at: nextArgIndex.
					nextArgIndex := nextArgIndex + 1 ]
				ifFalse: [ m := self labelMorphFor: s ].
			self addMorphBack: m ].
	self isReporter
		ifFalse: [ ^ self ].
	submorphs first isSquareArg
		ifTrue: [ self addMorphFront: self newSpacer ].
	submorphs last isSquareArg
		ifTrue: [ self addMorphBack: self newSpacer ]
]

{ #category : #private }
CommandBlockMorph >> argMorphFor: specString [
	"Answer an argument morph for the given argument specification string. Set it's color appropriately."

	| m |
	m := self script uncoloredArgMorphFor: specString.
	(m isKindOf: ColorArgMorph)
		ifTrue: [m color: Color random].
	^ m

]

{ #category : #private }
CommandBlockMorph >> argMorphToReplace: aMorph [
	"Answer a new argument morph to be used to replace the given morph. Answer nil if the given morph is not one of my argMorphs."

	| i argSpecs spec argM defaults v |
	i := argMorphs indexOf: aMorph ifAbsent: [ ^ nil ].
	argSpecs := self argSpecs.
	i > argSpecs size
		ifTrue: [ ^ nil ].
	argM := self argMorphFor: (argSpecs at: i).
	(#setVar:to: = selector and: [ (argSpecs at: i) = '%n' ])
		ifTrue: [ ^ argM stringExpression: '0' ].
	spec := self script blockSpecAt: selector.
	spec ifNil: [ ^ argM ].
	defaults := receiver defaultArgsFor: spec.
	i <= defaults size
		ifTrue: [ v := defaults at: (argPermutation indexOf: i).
			v isString
				ifTrue: [ argM isExpressionArg
						ifTrue: [ argM defaultValueFromSpec: v localized ]
						ifFalse: [ argM defaultValue: v localized ] ]
				ifFalse: [ argM defaultValue: v ] ].
	^ argM
]

{ #category : #accessing }
CommandBlockMorph >> argMorphs [

	^ argMorphs

]

{ #category : #accessing }
CommandBlockMorph >> argPermutation: aSet [

	argPermutation := aSet

]

{ #category : #private }
CommandBlockMorph >> argSpecs [
	^ (self class parseCommandSpec: commandSpec)
		select: [ :s | self class isArgSpec: s ]
]

{ #category : #accessing }
CommandBlockMorph >> args [
	"Answer my arguments evaluated and permuted into the order expected by the underlying Squeak method."

	^ self organizeArgs: (argMorphs collect: [:m | m evaluate]) asArray

]

{ #category : #evaluation }
CommandBlockMorph >> argumentAt: index [
	"Returns the argument morph at the given index."

	^ argMorphs at: (argPermutation at: index).

]

{ #category : #evaluation }
CommandBlockMorph >> argumentCount [
	"Returns the number of arguments to this command block."

	^ argMorphs size

]

{ #category : #'stack/tuple conversion' }
CommandBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: selector.
	(self organizeArgs: argMorphs)
		do: [ :each | 
			stream
				nextPut:
					(each isArgMorph | (each isKindOf: EventTitleMorph)
						ifTrue: [ each evaluate ]
						ifFalse: [ each asBlockTuple ]) ].
	^ stream contents
]

{ #category : #'code generation' }
CommandBlockMorph >> blockArgs [
	"^ submorphs select: [:m | (m isKindOf: ArgMorph) or: [m isKindOf: ReporterBlockMorph] ]"
	^ self organizeArgs: argMorphs asArray

]

{ #category : #evaluation }
CommandBlockMorph >> coerceArgs [
	^ self coerceArgs: self args
]

{ #category : #evaluation }
CommandBlockMorph >> coerceArgs: argList [
	"Answer an arugments array in which all arguments that should be numbers have been coerced to numbers if necessary."

	| args specialCommands |
	args := argList asArray.
	(self script specialCommands includes: selector)
		ifFalse: [ "ensure args are numbers where numbers are expected"
			args := argList asArray
				with: self numberArgFlags
				collect: [ :each :flag | 
					flag
						ifTrue: [ each asNumberNoError ]
						ifFalse: [ each ] ] ].
	^ args
]

{ #category : #accessing }
CommandBlockMorph >> color: aColor [

	super color: aColor.
	self layoutChanged.

]

{ #category : #accessing }
CommandBlockMorph >> commandSpec [

	^ commandSpec

]

{ #category : #accessing }
CommandBlockMorph >> commandSpec: aString [
	"Set my command spec string. See my class comment."
	"CommandBlockMorph new commandSpec: 'forward %n'"

	commandSpec := aString.
	numberArgFlags := nil.
	self addLabel.
	self addCommandIcons.

]

{ #category : #accessing }
CommandBlockMorph >> defaultArgs: defaultValues [
	"Set the default values of my arguments from the given list."

	| argM defaultValue |
	1 to: (defaultValues size min: argMorphs size) do: [ :i | 
		argM := argMorphs at: (argPermutation at: i).
		defaultValue := defaultValues at: i.
		argM isExpressionArg
			ifTrue: [ argM defaultValueFromSpec: defaultValue ]
			ifFalse: [ argM defaultValue: defaultValue ] ]
]

{ #category : #evaluation }
CommandBlockMorph >> evaluate [
	^ self evaluateWithArgs: self args
]

{ #category : #evaluation }
CommandBlockMorph >> evaluateFunctionWithArgs: args [
	^ receiver evaluateFunction: selector withArgs: args
]

{ #category : #evaluation }
CommandBlockMorph >> evaluateInfixWithArgs: rawArgs [
	^ receiver evaluateInfix: selector withArgs: rawArgs
]

{ #category : #evaluation }
CommandBlockMorph >> evaluateWithArgs: rawArgs [
	"Evalue this block with the given argument list."

	| args |
	^ selector isInfix
		ifTrue: [ self evaluateInfixWithArgs: rawArgs ]
		ifFalse: [ args := self coerceArgs: rawArgs.
			self evaluateFunctionWithArgs: args ]
]

{ #category : #private }
CommandBlockMorph >> fixBlockLayout [
	"Update the positions of my submorphs."

	| isFirst h x minXForArgs hAdjust nextB w oldPos oldExtent |
	blockLayoutNeeded
		ifFalse: [ ^ self ].
	super fixBlockLayout.
	oldPos := self position.
	oldExtent := self extent.
	hAdjust := 4.
	isFirst := true.
	h := 14.	"minimum height"
	self nonControlFlowSubmorphs
		do: [ :m | 
			(m isBlockMorph)
				ifTrue: [ m fixBlockLayout ].
			(m isArgMorph)
				ifTrue: [ m fixArgLayout ].
			(isFirst and: [ (m isKindOf: StringMorph) not ])
				ifTrue: [ "extra space when an arg overlaps with notch"
					h := h max: m height + 3.
					hAdjust := 1 ].
			isFirst := false.
			h := h max: m height ].
	((self isCBlock) or: [ self isIfElseBlock ])
		ifTrue: [ minXForArgs := self left + PuzzleInset + PuzzleWidth + 8 ]
		ifFalse: [ minXForArgs := self left ].
	h := h + 10.
	self isReporter
		ifTrue: [ h := h - 2.
			hAdjust := 2 ].
	self isStop
		ifTrue: [ h := h - 5.
			hAdjust := 0 ].
	x := self left + 5.
	self nonControlFlowSubmorphs
		do: [ :m | 
			(m isKindOf: StringMorph)
				ifTrue: [ m color: self labelColor ]
				ifFalse: [ x := x max: minXForArgs ].
			m position: x @ (self top + ((h - hAdjust - m height) // 2)).
			x := x + m width + 4 ].
	w := x - self left max: 37.
	(self isCBlock or: [ self isIfElseBlock ])
		ifTrue: [ w := w max: 71 ].
	self extent: w @ h.
	(nextB := self nextBlock)
		ifNotNil: [ self isCBlock
				ifFalse: [ nextB position: self left @ (self bottom - 4) ].
			nextB fixBlockLayout ]
]

{ #category : #initialization }
CommandBlockMorph >> initialize [

	super initialize.
	commandSpec := ''.
	argMorphs := OrderedCollection new.
	receiver := nil.
	selector := nil.
	isTimed := false.

]

{ #category : #testing }
CommandBlockMorph >> isCommandBlock [
	^ true
]

{ #category : #testing }
CommandBlockMorph >> isForever [

	^ (selector = #doForever) | (selector = #doForeverIf)

]

{ #category : #testing }
CommandBlockMorph >> isStop [
	^ receiver stopBlocks includes: selector
]

{ #category : #testing }
CommandBlockMorph >> isTimed [

	^ isTimed

]

{ #category : #testing }
CommandBlockMorph >> isTimed: aBoolean [
	"Indicates that this block's evaluate method will be called repeatedly throughout some time interval."

	isTimed := aBoolean.
]

{ #category : #'code generation' }
CommandBlockMorph >> labelId [
	^ labelId
]

{ #category : #'code generation' }
CommandBlockMorph >> labelId: anInteger [
	labelId := anInteger.
]

{ #category : #private }
CommandBlockMorph >> labelMorphFor: aString [
	| s |
	s := aString.
	"commandSpec isUnicode ifTrue: [s := UTF8 withAll: s]."
	^ (StringMorph contents: s font: ScratchTranslator labelFont)
		color: self labelColor
]

{ #category : #private }
CommandBlockMorph >> newSpacer [
	^ Morph new
		color: Color transparent;
		extent: 2 @ 5;
		yourself
]

{ #category : #private }
CommandBlockMorph >> nextBlock [
	"Answer the block following myself in the block sequence or nil if I am the last block in the sequence. Each block is a submorph of the previous block."

	^ self submorphs
		detect: [:m | (m isKindOf: BlockMorph) and: [(argMorphs includes: m) not]]
		ifNone: [nil]

]

{ #category : #private }
CommandBlockMorph >> nextBlock: aBlock [
	"Add the given block as the block following me. Delete old nextBlock, if any."

	self nextBlock ifNotNil: [self nextBlock delete].
	self addMorph: aBlock.

]

{ #category : #accessing }
CommandBlockMorph >> numberArgFlags [
	"Answer an array of booleans indicating which of my arguments must be numbers. Compute on first use and cache the result."

	| argSpecs |
	numberArgFlags ifNotNil: [ ^ numberArgFlags ].
	argSpecs := (self class parseCommandSpec: commandSpec)
		select: [ :s | self class isArgSpec: s ].
	argSpecs := self organizeArgs: argSpecs.
	numberArgFlags := argSpecs
		collect:
			[ :spec | (self script uncoloredArgMorphFor: spec) isNumberExpression ].
	^ numberArgFlags
]

{ #category : #evaluation }
CommandBlockMorph >> organizeArgs: argList [
	"Answer an arugments array in which all arguments have been rearranged to the original English permutation"

	argPermutation ifNil: [ ^ argList ].
	(#(+ - / * =) includes: selector)
		ifTrue: [ ^ argList ].
	^ argPermutation collect: [ :each | argList at: each ]
]

{ #category : #accessing }
CommandBlockMorph >> receiver [

	^ receiver

]

{ #category : #accessing }
CommandBlockMorph >> receiver: anObject [
	"Set my receiver object."

	receiver := anObject.

]

{ #category : #private }
CommandBlockMorph >> replaceArgMorph: oldMorph by: newMorph [
	"Replace oldMorph with newMorph in my argMorphs and submorphs lists. This is done when dropping a reporter block onto one of my arguments."

	argMorphs := argMorphs collect: [:m |
		m == oldMorph ifTrue: [newMorph] ifFalse: [m]].
	self replaceSubmorph: oldMorph by: newMorph.
	self layoutChanged.

]

{ #category : #accessing }
CommandBlockMorph >> script [
	^ receiver
]

{ #category : #accessing }
CommandBlockMorph >> selector [

	^ selector

]

{ #category : #accessing }
CommandBlockMorph >> selector: aSymbol [

	selector := aSymbol.

]

{ #category : #processes }
CommandBlockMorph >> startProcess [
	self stopProcess.
	self receiver ifNil: [ ^ self ].
	self applicationDo: [ :app | app startProcessFor: self ].
	self changed
]

{ #category : #menus }
CommandBlockMorph >> tabToNextField: evt [
	"Move the keyboard focus to the next submorph that responds to keyboard events."

	| fields current |
	fields := argMorphs select: [ :m | m isExpressionArg ].
	current := (1 to: fields size)
		detect: [ :i | (fields at: i) labelMorph == evt hand keyboardFocus ]
		ifNone: [ fields size ].
	evt hand
		newKeyboardFocus: (fields at: current \\ fields size + 1) labelMorph
]

{ #category : #private }
CommandBlockMorph >> updateReferencesUsing: deepCopier [
	"Update my arg morphs."

	super updateReferencesUsing: deepCopier.
	argMorphs := argMorphs collect: [:m | deepCopier references at: m ifAbsent: [m]].

]
