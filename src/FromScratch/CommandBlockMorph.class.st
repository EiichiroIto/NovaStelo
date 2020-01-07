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
		'titleMorph',
		'receiver',
		'selector',
		'isReporter',
		'isTimed',
		'wantsName',
		'wantsPossession',
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
	#turnLeft: = selector ifTrue: [
		f := ScratchTheme formAt: #turnCCW.
		m := self firstSubmorph delete.
		self addMorphFront: (ImageMorph new form: f).
		self addMorphFront: m].

	#turnRight: = selector ifTrue: [
		f := ScratchTheme formAt: #turnCW.
		m := self firstSubmorph delete.
		self addMorphFront: (ImageMorph new form: f).
		self addMorphFront: m].

	#stopAll = selector ifTrue: [
		f := ScratchTheme formAt: #stopButton.
		self addMorphBack: (ImageMorph new form: f)].

]

{ #category : #private }
CommandBlockMorph >> addLabel [
	"Add a label for my command and arguments. This is the method that really creates the whole block."
	"Details: We remove all the pieces of this block, and then reassemble them, being careful not to destroy any argument morphs that we might still want to use. This is helpful if someone adds/removes parameters from a hat block."

	| tokens args nextArgIndex m next |
	commandSpec ifNil: [^ self].

	"we make sure not to remove the next block."
	next := self nextBlock.
	self removeAllMorphsIn: (self submorphs reject: [:t | t = next]).

	tokens := CommandBlockMorph parseCommandSpec: commandSpec.
	args := tokens select: [:s | CommandBlockMorph isArgSpec: s].

	"remove any excess arg morphs from the list."
	[argMorphs size > args size] whileTrue: [
		m := argMorphs last.
		argMorphs remove: m.

		"if the argument we're throwing out is anything complicated, we'd like to keep it around in the world."
		(m isKindOf: BlockMorph) ifTrue: [m openInWorld]].

	"create new arg morphs."
	[argMorphs size < args size] whileTrue: [
		argMorphs addLast: (self argMorphFor: (args at: argMorphs size + 1))].

	nextArgIndex := 1.

	tokens do: [:s |
		(CommandBlockMorph isArgSpec: s)
			ifTrue:	[
				m := argMorphs at: nextArgIndex.
				nextArgIndex := nextArgIndex + 1]
			ifFalse:	[
				m := self labelMorphFor: s].
		self addMorphBack: m].

	self isReporter ifTrue: [
		m := submorphs first.
		((m isKindOf: ChoiceArgMorph) | (m isKindOf: SpriteArgMorph)) ifTrue: [  "add spacer"
			self addMorphFront: (Morph new color: Color transparent; extent: 2@5)].

		m := submorphs last.
		((m isKindOf: ChoiceArgMorph) | (m isKindOf: SpriteArgMorph)) ifTrue: [  "add spacer"
			self addMorphBack: (Morph new color: Color transparent; extent: 2@5)]].

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
	i := argMorphs indexOf: aMorph ifAbsent: [^ nil].
	argSpecs := (CommandBlockMorph parseCommandSpec: commandSpec) select: [:s | CommandBlockMorph isArgSpec: s].
	i > argSpecs size ifTrue: [^ nil].
	argM := self argMorphFor: (argSpecs at: i).

	(#setVar:to: = selector and: [(argSpecs at: i) = '%n']) ifTrue: [
		^ argM stringExpression: '0'].
	spec := self script blockSpecAt: selector.
	spec ifNil: [ ^ argM ].

	defaults := receiver defaultArgsFor: spec.
	i <= defaults size ifTrue: [
		v := defaults at: (argPermutation indexOf: i).
		(v isKindOf: String)
			ifTrue: [
				(argM isKindOf: ExpressionArgMorph)
					ifTrue: [argM defaultValueFromSpec: v localized]
					ifFalse: [argM defaultValue: v localized]]
			ifFalse: [argM defaultValue: v]].

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

	| blockTuple argList arg |
	blockTuple := Array new: argMorphs size + 1.
	blockTuple at: 1 put: selector.
	argList := argMorphs.
	argList := self organizeArgs: argList.
	"((#(+ - / * =) includes: selector) and: [ScratchTranslator isRTLMath])
		ifTrue: [argList := argList reversed]."
	1 to: argList size do: [ :i | 
		arg := argList at: i.
		(arg isArgMorph) | (arg isKindOf: EventTitleMorph)
			ifTrue: [ blockTuple at: i + 1 put: arg evaluate ]
			ifFalse: [ blockTuple at: i + 1 put: arg asBlockTuple ] ].
	^ blockTuple
]

{ #category : #'code generation' }
CommandBlockMorph >> blockArgs [
	"^ submorphs select: [:m | (m isKindOf: ArgMorph) or: [m isKindOf: ReporterBlockMorph] ]"
	^ self organizeArgs: argMorphs asArray

]

{ #category : #evaluation }
CommandBlockMorph >> coerceArgs: argList [
	"Answer an arugments array in which all arguments that should be numbers have been coerced to numbers if necessary."

	| args specialCommands numFlags |
	args := argList asArray.
	specialCommands := #(
		setVar:to:).

	(specialCommands includes: selector) ifFalse: [
		"ensure args are numbers where numbers are expected"
		numFlags := self numberArgFlags.
		1 to: args size do: [:i |
			(numFlags at: i) ifTrue: [args at: i put: (args at: i) asNumberNoError]]].

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
	1 to: (defaultValues size min: argMorphs size) do: [:i |
		argM := argMorphs at: (argPermutation at: i).
		defaultValue := defaultValues at: i.
		(argM  isKindOf: ExpressionArgMorph)
			ifTrue: [argM defaultValueFromSpec: defaultValue]
			ifFalse: [argM defaultValue: defaultValue]].


]

{ #category : #evaluation }
CommandBlockMorph >> evaluate [

	^ self evaluateWithArgs: self args

]

{ #category : #evaluation }
CommandBlockMorph >> evaluateInfixWithArgs: rawArgs [
	"Evalue an infix operator with the given arguments list. Special case for comparison operatores when both operands are strings. Reverse order of comparison operands in RTL languages."
	"Note: The strings 'true' and 'false' in either English or the current language are equal to the boolean value that they name."

	| args result arg1 arg2 |
	args := rawArgs.

	#= = selector ifTrue: [
		"special case: check for equality between a boolean and the special strings 'true' or 'false'"
		((args first isString) and: [args second isKindOf: Boolean]) ifTrue: [
			(args first = 'true') ifTrue: [^ args second = true].
			(args first = 'false') ifTrue: [^ args second = false].
			"(args first = (ScratchTranslator translationFor: 'true')) ifTrue: [^ args second = true]."
			"(args first = (ScratchTranslator translationFor: 'false')) ifTrue: [^ args second = false]"].
		((args first isKindOf: Boolean) and: [args second isString]) ifTrue: [
			(args second = 'true') ifTrue: [^ args first = true].
			(args second = 'false') ifTrue: [^ args first = false].
			"(args second = (ScratchTranslator translationFor: 'true')) ifTrue: [^ args first = true]."
			"(args second = (ScratchTranslator translationFor: 'false')) ifTrue: [^ args first = false]"]].

	(#(< = >) includes: selector)
		ifTrue: [((args first isString) or: [args second isString]) ifTrue: [
				arg1 := receiver interpretStringAsNumberIfPossible: args first.
				arg2 := receiver interpretStringAsNumberIfPossible: args second.
				((arg1 isString) and: [arg2 isString]) ifTrue: [
					result := args first compare: args second.
					#< = selector ifTrue: [^ result = 1].
					#= = selector ifTrue: [^ result = 2].
					#> = selector ifTrue: [^ result = 3]].
				((arg1 isNumber) and: [arg2 isNumber]) ifTrue: [
					^ arg1 perform: selector with: arg2].
				^ false]]
		"ifFalse: [(ScratchTranslator isRTLMath and: [((selector = #\\) not)]) ifTrue: [args := args reversed]]". "RTLMath operators are RTL"

	(#(& |) includes: selector) ifTrue: [^ args first perform: selector with: args second].

	^ args first asNumberNoError perform: selector with: args second asNumberNoError

]

{ #category : #evaluation }
CommandBlockMorph >> evaluateWithArgs: rawArgs [
	"Evalue this block with the given argument list."

	| args |
	"special case for math and boolean infix operators"
	selector isInfix ifTrue: [^ self evaluateInfixWithArgs: rawArgs].

	args := self coerceArgs: rawArgs..

	"special case for unary operators"
	(#(abs not rounded sqrt truncated) includes: selector) ifTrue: [^ args first perform: selector].

	^ receiver perform: selector withArguments: args

]

{ #category : #'object i/o' }
CommandBlockMorph >> fieldsVersion [

	^ 1

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

{ #category : #'object i/o' }
CommandBlockMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		commandSpec
		argMorphs
		titleMorph
		receiver
		selector
		isReporter
		isTimed
		wantsName
		wantsPossession
	) from: anObjStream.

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

	^ (selector = #stopThread) | (selector = #stopAll) | (selector = #return:)
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

{ #category : #private }
CommandBlockMorph >> labelColor [
	"Answer a label color, either black or white, that maximizes the contrast with my color."

	^ LabelColor

"old:
	^ self color luminance > 0.8
		ifTrue: [Color black]
		ifFalse: [Color white]
"

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
	^ (StringMorph contents: s font: (ScratchTheme labelFont))
		color: self labelColor
]

{ #category : #private }
CommandBlockMorph >> mapReceiver: oldObj to: newObj [
	"Used in cloning an object to make blocks that refererred to the original object new refer to the new copy."

	receiver == oldObj ifTrue: [receiver := newObj].
	argMorphs do: [:arg |
		(arg isKindOf: CommandBlockMorph) ifTrue: [
			arg mapReceiver: oldObj to: newObj]].

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

	| argSpecs argM |
	numberArgFlags ifNotNil: [ ^ numberArgFlags ].
	argSpecs := (CommandBlockMorph parseCommandSpec: commandSpec)
		select: [ :s | CommandBlockMorph isArgSpec: s ].
	argSpecs := self organizeArgs: argSpecs.
	numberArgFlags := argSpecs
		collect: [ :spec | 
			argM := self script uncoloredArgMorphFor: spec.
			(argM isKindOf: ExpressionArgMorph)
				ifTrue: [ argM isNumberExpression ]
				ifFalse: [ false ] ].
	^ numberArgFlags.
]

{ #category : #evaluation }
CommandBlockMorph >> organizeArgs: argList [
	"Answer an arugments array in which all arguments have been rearranged to the original English permutation"

	| newArgList |
	argPermutation ifNil: [^ argList].
	(#(+ - / * =) includes: selector) ifTrue: [^ argList].
	newArgList := #().
	1 to: argPermutation size do: [:i |
		newArgList := newArgList copyWith: (argList at: (argPermutation at: i))].
	^ newArgList

]

{ #category : #private }
CommandBlockMorph >> parseCommandSpec [
	"Answer an array of token strings containing my keywords and argument specs."

	| spec result len i j |
	result := OrderedCollection new.
	spec := commandSpec.
	"(spec isKindOf: UTF8) ifTrue: [spec := String withAll: spec]."
	len := commandSpec size.

	i := 1.
	[(i < len) and: [(spec at: i) isSeparator]] whileTrue: [i := i + 1].
	[i <= len] whileTrue: [
		j := spec indexOf: $% startingAt: i.
		j > 0
			ifTrue: [
				j > i ifTrue: [result addLast: (spec copyFrom: i to: j - 1)].
				j < len
					ifTrue: [result addLast: (spec copyFrom: j to: j + 1)]
					ifFalse: [result addLast: '%'].
				i := j + 2]
			ifFalse: [
				result addLast: (spec copyFrom: i to: len).
				i := len + 1]].

	^ result asArray collect: [:s | s trimBoth]

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

{ #category : #menus }
CommandBlockMorph >> rightButtonMenu: anEvent [
	| menu choice spec |
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	"menu add: 'help' selector: #value: argument: #presentHelpScreen."
	owner isBlockPalette
		ifFalse: [ menu addLine.
			(#(+ - * / \\) includes: selector)
				ifTrue: [ #(+ - * / mod)
						with: #(+ - * / \\)
						do: [ :s :op | menu add: s selector: #value: argument: op ] ].
			(#(< = >) includes: selector)
				ifTrue: [ #(< = >) do: [ :op | menu add: op selector: #value: argument: op ] ].
			(#(& |) includes: selector)
				ifTrue: [ #(and or)
						with: #(& |)
						do: [ :s :op | menu add: s selector: #value: argument: op ] ].
			menu addLine.
			"menu add: 'duplicate' selector: #value: argument: #duplicate."
			self owner isBlockMorph
				ifFalse:
					[ "can't yet delete a blocks inside a script" menu add: 'delete' selector: #value: argument: #delete ] ].

	"sFrame := self meOrOwnerThatIsA: ScratchFrameMorph."
	"(sFrame notNil and: [#(sensor: sensorPressed:) includes: selector]) ifTrue: [
		menu addLine.
		menu add: 'show ScratchBoard watcher' selector: #value: argument: #showSensorBoard.
		sFrame workPane scratchServer
			ifNil: [menu add: 'enable remote sensor connections' selector: #value: argument: #enableRemoteSensors]
			ifNotNil: [menu add: 'disable remote sensor connections' selector: #value: argument: #exitScratchSession]]."

	"DebugMenu ifTrue: [
		menu addLine.
		menu add: 'show tuples' selector: #value: argument: #showTuples]."
	menu localize.
	menu invokeAt: anEvent cursorPoint in: self world.
	choice ifNil: [ ^ self ].
	(#(duplicate delete) includes: choice)
		ifTrue: [ ^ self perform: choice ].
	"choice = #showSensorBoard ifTrue: [sFrame showSensorBoard. ^ self].
	choice = #enableRemoteSensors ifTrue: [sFrame enableRemoteSensors. ^ self]."
	"choice = #exitScratchSession ifTrue: [sFrame exitScratchSession. ^ self]."
	"choice = #showTuples ifTrue: [^ self showTuples]."

	"change operator"
	spec := '%n ' , choice , ' %n'.
	'\\' = choice
		ifTrue: [ spec := '%n mod %n' ].
	'&' = choice
		ifTrue: [ spec := '%b and %b' ].
	'|' = choice
		ifTrue: [ spec := '%b or %b' ].
	self commandSpec: spec.
	self selector: choice
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

{ #category : #accessing }
CommandBlockMorph >> selectorAndArg [
	"Answer an array containing my selector and argument (if any)."

	| args |
	args := self args.
	^ Array with: selector with: (args size = 0 ifTrue: [nil] ifFalse: [args first])

]

{ #category : #processes }
CommandBlockMorph >> start [
	self stop.
	self receiver ifNil: [ ^ self ].
	self applicationDo: [ :app | app startProcessFor: self ].
	self changed
]

{ #category : #'object i/o' }
CommandBlockMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		commandSpec
		argMorphs
		titleMorph
		receiver
		selector
		isReporter
		isTimed
		wantsName
		wantsPossession
	) on: anObjStream.

]

{ #category : #menus }
CommandBlockMorph >> tabToNextField: evt [
	"Move the keyboard focus to the next submorph that responds to keyboard events."

	| fields current |
	fields := argMorphs select: [:m | m isKindOf: ExpressionArgMorph].

	current := (1 to: fields size) detect: [:i | (fields at: i) labelMorph == evt hand keyboardFocus] ifNone: [fields size].
	evt hand newKeyboardFocus: (fields at: (current \\ fields size) + 1) labelMorph.

]

{ #category : #private }
CommandBlockMorph >> updateReferencesUsing: deepCopier [
	"Update my arg morphs."

	super updateReferencesUsing: deepCopier.
	argMorphs := argMorphs collect: [:m | deepCopier references at: m ifAbsent: [m]].

]
