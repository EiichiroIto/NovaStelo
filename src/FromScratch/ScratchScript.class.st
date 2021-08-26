Class {
	#name : #ScratchScript,
	#superclass : #Object,
	#instVars : [
		'blocksBin',
		'project',
		'blockDef',
		'argBuilder'
	],
	#category : #'FromScratch-Project'
}

{ #category : #'ston-core' }
ScratchScript class >> stonAllInstVarNames [
	^ #(blocksBin project)
]

{ #category : #'argument menus' }
ScratchScript >> addArgBuilder [
	argBuilder
		addBooleanArg: $b;
		addEventTitleArg: $e;
		addChoiceArg: $f selector: #mathFunctionNames initialChoice: 'sqrt';
		addLocalVarArg: $l;
		addChoiceArg: $L selector: #listVarNames;
		addSpriteArg: $m;
		addNumberExpressArg: $n initialExpression: '10';
		addChoiceArg: $S selector: #subNames;
		addStringExpressArg: $s;
		addChoiceArg: $v selector: #varNames
]

{ #category : #accessing }
ScratchScript >> addEventNamesTo: aSet [
	"Add the names of all events implemented by this morph, excluding keyboard events. Suppress duplicates (ignoring case differences)."

	blocksBin isMorph
		ifFalse: [ ^ self ].
	blocksBin
		allMorphsDo: [ :m | 
			m class = EventTitleMorph
				ifTrue: [ (aSet anySatisfy: [ :el | (el compare: m eventName) = 2 ])
						ifFalse: [ aSet add: m eventName ] ] ]
]

{ #category : #blocks }
ScratchScript >> addGenericListBlocksTo: page y: startY [
	"Add the generic list blocks to the given page starting at the given y offset."

	| addButton deleteButton x y |
	addButton := ScratchTheme
		buttonLabel: 'Make a list' localized
		selector: #addList:.
	deleteButton := ScratchTheme
		buttonLabel: 'Delete a list' localized
		selector: #deleteList:.
	x := 13.
	y := startY + 10.
	page
		addMorph:
			(addButton
				target: self project application;
				arguments: {self};
				position: x @ y).
	y := addButton bottom + 3.
	self listVarNames isEmpty
		ifTrue: [ ^ y ].
	page
		addMorph:
			(deleteButton
				target: self project application;
				arguments: {self};
				position: x @ y).
	y := deleteButton bottom + 10.
	"y := (self addListReportersTo: page x: x y: y) + 10."
	(self blocksFor: 'list')
		do: [ :blockOrSym | 
			blockOrSym = #- | (blockOrSym = #~)
				ifTrue: [ "insert a half space"
					blockOrSym = #-
						ifTrue: [ y := y + 15 ].
					blockOrSym = #~
						ifTrue: [ y := y + 5 ] ]
				ifFalse: [ self updateListArgFor: blockOrSym.
					y := self createBlock: blockOrSym atPosition: x @ y onPage: page.
					page submorphs last color: ScratchTheme listBlockColor ] ].
	^ y
]

{ #category : #blocks }
ScratchScript >> addGenericVariableBlocksTo: page x: x y: startY [
	"Add the generic variable blocks to the given page starting at the given y offset. Answer the new y."

	| y vName block varBlocks |
	y := startY.

	"pick a default variable name"
	self varNames isEmpty
		ifTrue: [ ^ y ].
	vName := self varNames first.
	varBlocks := OrderedCollection new.
	block := SetterBlockMorph new
		receiver: self;
		initSetterForVar: vName.
	block expressionArg stringExpression: '0'.
	varBlocks add: block.
	block := SetterBlockMorph new
		receiver: self;
		initChangerForVar: vName.
	block expressionArg numExpression: '1'.
	varBlocks add: block.
	(self blocksFor: 'variables')
		do: [ :b | 
			b defaultArgs: (Array with: vName).
			varBlocks add: b ].
	varBlocks
		do: [ :b | 
			b color: ScratchTheme variableBlockColor.
			page addMorph: (b position: x @ y).
			y := b bottom + 3 ].
	^ y
]

{ #category : #blocks }
ScratchScript >> addGenericVariableBlocksTo: page y: startY [
	| addButton deleteButton x y |
	addButton := ScratchTheme
		buttonLabel: 'Make a variable' localized
		selector: #addVariable:.
	deleteButton := ScratchTheme
		buttonLabel: 'Delete a variable' localized
		selector: #deleteVariable:.
	x := 13.
	page
		addMorph:
			(addButton
				target: self project application;
				arguments: {self};
				position: x @ startY).
	y := addButton bottom + 3.
	self varNames notEmpty
		ifTrue: [ page
				addMorph:
					(deleteButton
						target: self project application;
						arguments: {self};
						position: x @ y).
			y := deleteButton bottom + 10.
			y := self addVariableReportersTo: page x: x y: y.
			y := y + 12.
			y := self addGenericVariableBlocksTo: page x: x y: y ].
	^ y
]

{ #category : #variables }
ScratchScript >> addList: aString [
	self subclassResponsibility
]

{ #category : #blocks }
ScratchScript >> addSubBlock: aPoint name: aString [
	| morph |
	morph := self newSubMorph
		position: aPoint;
		subName: aString;
		yourself.
	blocksBin addMorph: morph
]

{ #category : #variables }
ScratchScript >> addVariable: aString [
	self subclassResponsibility
]

{ #category : #blocks }
ScratchScript >> addVariableReportersTo: page x: x y: startY [
	| y b watcherButton yOffset |
	y := startY.
	self varNames
		do: [ :vName | 
			b := VariableBlockMorph new
				commandSpec: vName;
				receiver: self.
			watcherButton := self createToggleButtonFor: b.
			yOffset := (b fullBounds height - watcherButton height) // 2.
			self useVariableWatcher
				ifTrue: [ page addMorph: (watcherButton position: x @ (y + yOffset)) ].
			page addMorph: (b position: (x + watcherButton width + 4) @ y).
			y := y + b height + 3 ].
	^ y
]

{ #category : #accessing }
ScratchScript >> blockCategories [
	^ self blockDef blockCategories
]

{ #category : #accessing }
ScratchScript >> blockColorFor: aCategory [
	^ self blockDef blockColorFor: aCategory
]

{ #category : #accessing }
ScratchScript >> blockDef [
	^ blockDef ifNil: [ self setupBlockDef ]
]

{ #category : #blocks }
ScratchScript >> blockFromSpec: spec color: blockColor [
	| blockLabelSpec blockType selector defaultArgs block rcvr argPermutation c |
	c := blockColor.
	blockLabelSpec := (spec at: 1) localized.
	argPermutation := CommandBlockMorph
		argPermutationForSpec: (spec at: 1)
		withTranslation: blockLabelSpec.
	blockType := spec at: 2.
	selector := (spec at: 3) asSymbol.
	defaultArgs := self defaultArgsFor: spec.
	(#(E K M S T L G) includes: blockType)
		ifTrue: [ ^ (self hatBlockType: blockType) color: blockColor ].
	(blockType includes: $c)
		ifTrue: [ block := selector = #doIfElse
				ifTrue: [ IfElseBlockMorph new isSpecialForm: true ]
				ifFalse: [ CBlockMorph new isSpecialForm: true ] ]
		ifFalse: [ (blockType includes: $r) | (blockType includes: $b)
				ifTrue: [ block := ReporterBlockMorph new.
					c := c darker ]
				ifFalse: [ block := CommandBlockMorph new ] ].
	(blockType includes: $b)
		ifTrue: [ block isBoolean: true ].
	(blockType includes: $s)
		ifTrue: [ block isSpecialForm: true ].
	(blockType includes: $t)
		ifTrue: [ block isTimed: true ].
	rcvr := self.
	^ block
		argPermutation: argPermutation;
		color: c;
		selector: selector;
		receiver: rcvr;
		commandSpec: blockLabelSpec;
		defaultArgs: defaultArgs;
		yourself
]

{ #category : #'block specs' }
ScratchScript >> blockFromTuple: tuple receiver: scriptOwner [
	"Answer a new block for the given tuple."

	| k spec blockColor block argCount arg argBlock |
	k := tuple first.
	k = #localVar
		ifTrue: [ ^ self localVarBlockFromTuple: tuple receiver: scriptOwner ].
	(#(readVariable changeVariable) includes: k)
		ifTrue: [ ^ self variableBlockFromTuple: tuple receiver: scriptOwner ].
	(#(EventHatMorph SubHatMorph) includes: k)
		ifTrue: [ block := self hatBlockFromTuple: tuple receiver: scriptOwner.
			^ block ].
	"#scratchComment = k
		ifTrue: [ block := ScratchCommentMorph new.
			tuple size > 1
				ifTrue: [ block commentMorph contents: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			tuple size > 3
				ifTrue: [ block width: (tuple at: 4) ].
			tuple size > 4
				ifTrue: [ block anchor: (self blockWithID: (tuple at: 5)) ].
			^ block ].
	#comment: = k
		ifTrue: [ block := CommentBlockMorph new.
			tuple size > 1
				ifTrue: [ block comment: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			block color: (Color r: 0.8 g: 0 b: 0).
			^ block ]."
	spec := self blockDef blockSpecAt: k.
	spec
		ifNil: [ ^ scriptOwner
				blockFromSpec: #('obsolete!' - yourself)
				color: Color red ].
	blockColor := self blockDef blockColorAt: k.
	block := scriptOwner blockFromSpec: spec color: blockColor.
	block isCommandBlock
		ifTrue: [ argCount := block argumentCount min: tuple size - 1.
			1 to: argCount do: [ :i | 
				arg := tuple at: i + 1.
				arg isArray
					ifTrue: [ "argument is a block"
						(arg size = 1 and: [ arg first isArray ])
							ifTrue: [ arg := arg first ].
						argBlock := self blockFromTuple: arg receiver: scriptOwner.
						block replaceArgMorph: (block argumentAt: i) by: argBlock ]
					ifFalse: [ "argument is a value" (block argumentAt: i) defaultValue: arg ] ].
			block isCBlock
				ifTrue: [ tuple last isArray
						ifTrue: [ block
								firstBlockList: (self stackFromTupleList: tuple last receiver: scriptOwner) ] ].
			block isIfElseBlock
				ifTrue: [ arg := tuple at: tuple size - 1.
					arg isArray
						ifTrue: [ block
								trueBlock: (self stackFromTupleList: arg receiver: scriptOwner) ].
					arg := tuple at: tuple size.
					arg isArray
						ifTrue: [ block
								falseBlock: (self stackFromTupleList: arg receiver: scriptOwner) ] ].
			block isReporter
				ifTrue: [ ((spec at: 2) includes: $b)
						ifTrue: [ block isBoolean: true ] ] ].
	^ block
]

{ #category : #blocks }
ScratchScript >> blockIDOf: aMorph [
	| list |
	list := blocksBin allMorphs select: [ :each | each isBlockMorph ].
	^ list indexOf: aMorph
]

{ #category : #'block specs' }
ScratchScript >> blockSpecAt: aSymbol [
	^ self blockDef blockSpecAt: aSymbol
]

{ #category : #'block specs' }
ScratchScript >> blocks [
	"Answer a collection of block specifications for the blocks that are common to all objects. Block specificatons (Arrays) are interspersed with category names (Strings). A block specification is an Array of the form: (<block spec string> <block type> <selector> [optional initial argument values]).

	Explanation of flags:
		-	no flags
		b	boolean reporter
		c	c-shaped block containing a sequence of commands (always special form)
		r	reporter
		s	special form command with its own evaluation rule
		t	timed command, like wait or glide
		E	message event hat
		K	key event hat
		M	mouse-click event hat
		S	start event hat
		W	when <condition> hat (obsolete)"

	| blocks |
	blocks := #(
		'control'
			('when loop'					L	-)
			('when I receive %e'		E	-)
			-
			('repeat %n'					c	doRepeat 10)
			-
			('broadcast %e'				-	broadcast:)
			('call %S'						-	callSub: '')
			-
			('if %b'							c	doIf)
			('if %b'							c	doIfElse)
			('repeat until %b'			c	doUntil)
			-
			('return %n'					-	return: 0)
			('stop script'					-	stopThread)
			('stop all'						-	stopAll)
		'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)
			('%n * %n'						r	* - -)
			('%n / %n'						r	/ - -)
			('- %n'								r	negated: 1)
			-
			('pick random %n to %n'		r	randomFrom:to: 1 10)
			-
			('%s < %s'						b	< '' '')
			('%s = %s'						b	= '' '')
			('%s > %s'						b	> '' '')
			('%n between %n and %n'	b is:between:and: 50 0 100)
			-
			('%b and %b'					b	&)
			('%b or %b'						b	|)
			('not %b'							b	not:)
			-
			('%n mod %n'					r	\\ - -)
			('round %n'						r	rounded: -)
			('truncate %n'					r	truncated: -)
			-
			('%f of %n'						r	computeFunction:of: 'sqrt' 10)
		'sensing'
			('returned value'				r	returnValue)
	).

	^ blocks
]

{ #category : #blocks }
ScratchScript >> blocksBin [
	^ blocksBin
]

{ #category : #'block specs' }
ScratchScript >> blocksFor: aCategory [
	^ self blockDef blocksFor: aCategory script: self
]

{ #category : #blocks }
ScratchScript >> cleanUp [
	blocksBin cleanUp
]

{ #category : #'object i/o' }
ScratchScript >> convertStacksToTuples [
	"Convert my blocks bin from a morph containing block stack into a collection of (<point>, <tuple>) pairs the represent the same stacks in compact, language-independent form."

	| stacks blocks comments |
	blocksBin isArray
		ifTrue: [ ^ self ].
	stacks := blocksBin submorphs
		select: [ :m | m respondsTo: #tupleSequence ].
	blocks := stacks select: [ :m | m isBlockMorph ].
	comments := stacks select: [ :m | m isCommentMorph ].
	blocks := blocks
		collect: [ :blockM | 
			Array
				with: blockM position - blocksBin position
				with: blockM tupleSequence ].
	comments := comments
		collect: [ :blockM | 
			Array
				with: blockM position - blocksBin position
				with: blockM tupleSequence ].
	blocksBin := blocks , comments
]

{ #category : #'object i/o' }
ScratchScript >> convertTuplesToStacks [
	| tuplesList stack |
	blocksBin isArray
		ifFalse: [ ^ self ].
	tuplesList := blocksBin.
	blocksBin := ScratchScriptsMorph new
		project: self project;
		yourself.
	tuplesList
		do: [ :pair | 
			stack := self stackFromTupleList: pair second receiver: self.
			stack position: pair first.
			blocksBin addMorph: stack ]
]

{ #category : #private }
ScratchScript >> countBlockMorph: aMorph [
	| list |
	list := aMorph submorphs
		collect: [ :each | self countBlockMorph: each ].
	^ (list isEmpty ifTrue: [ 0 ] ifFalse: [ list sum ])
		+
			(aMorph isBlockMorph
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])
]

{ #category : #accessing }
ScratchScript >> countBlockMorphs [
	| list |
	list := self hatBlocks collect: [ :each | self countBlockMorph: each ].
	list isEmpty ifTrue: [ ^ 0 ].
	^ list sum
]

{ #category : #blocks }
ScratchScript >> createBlock: block atPosition: pos onPage: page [
	"Creates a block on the given page. If the block is one that can become a watcher, then a toggle button is created as well."

	| x y changingX toggleButton yOffset |
	x := pos x.
	y := pos y.
	changingX := x.
	block canBecomeWatcher
		ifTrue: [ toggleButton := self createToggleButtonFor: block.
			yOffset := (block fullBounds height
				- toggleButton fullBounds height) // 2.
			page addMorphBack: (toggleButton position: x @ (y + yOffset)).
			changingX := x + toggleButton fullBounds width + 4 ].
	block
		fixBlockLayout;
		position: changingX @ y.
	page addMorphBack: block.
	^ y + block height + 3
]

{ #category : #blocks }
ScratchScript >> createToggleButtonFor: block [
	| toggleButton |
	toggleButton := ToggleButton
		onForm: (ScratchTheme formAt: #watcherButtonPressed)
		offForm: (ScratchTheme formAt: #watcherButton).
	toggleButton
		target: self;
		actionSelector: #toggleWatcher:for:;
		arguments:
			{toggleButton.
			block};
		borderWidth: 0;
		setProperty: #balloonText toValue: 'View on stage' localized.
	self useVariableWatcher
		ifTrue: [ self updateWatcher: toggleButton for: block ].
	^ toggleButton
]

{ #category : #blocks }
ScratchScript >> defaultArgsFor: blockSpec [
	| defaultArgs sel |
	defaultArgs := blockSpec copyFrom: 4 to: blockSpec size.
	sel := (blockSpec at: 3) asSymbol.
	(#(broadcast: doBroadcastAndWait) includes: sel)
		ifTrue: [ defaultArgs := Array with: project defaultEventName ].
	^ defaultArgs
]

{ #category : #variables }
ScratchScript >> deleteList: aString [
	self subclassResponsibility
]

{ #category : #variables }
ScratchScript >> deleteVariable: aString [
	self subclassResponsibility
]

{ #category : #evaluation }
ScratchScript >> evaluateFor: aTopBlock [
	| selector args |
	selector := aTopBlock selector.
	args := aTopBlock coerceArgs.
	^ selector isInfix
		ifTrue: [ self evaluateInfix: selector withArgs: args ]
		ifFalse: [ self evaluateFunction: selector withArgs: args ]
]

{ #category : #evaluation }
ScratchScript >> evaluateFunction: aSymbol withArgs: anArgs [
	"Evalue this block with the given argument list."

	"special case for unary operators"

	"(#(abs not rounded sqrt truncated) includes: aSymbol)
		ifTrue: [ ^ anArgs first perform: aSymbol ]."
	^ self evaluator perform: aSymbol withArguments: anArgs
]

{ #category : #evaluation }
ScratchScript >> evaluateInfix: aSymbol withArgs: rawArgs [
	"Evalue an infix operator with the given arguments list. Special case for comparison operatores when both operands are strings. Reverse order of comparison operands in RTL languages."

	"Note: The strings 'true' and 'false' in either English or the current language are equal to the boolean value that they name."

	| arg1 arg2 |
	arg1 := rawArgs first.
	arg2 := rawArgs second.
	#= = aSymbol
		ifTrue: [ (arg1 isString and: [ arg2 isKindOf: Boolean ])
				ifTrue: [ arg1 = 'true'
						ifTrue: [ ^ arg2 = true ].
					arg1 = 'false'
						ifTrue: [ ^ arg2 = false ] ].
			((arg1 isKindOf: Boolean) and: [ arg2 isString ])
				ifTrue: [ arg2 = 'true'
						ifTrue: [ ^ arg1 = true ].
					arg2 = 'false'
						ifTrue: [ ^ arg1 = false ] ] ].
	(#(< = >) includes: aSymbol)
		ifTrue: [ (arg1 isString and: [ arg1 isNumberString ])
				ifTrue: [ arg1 := arg1 asNumber ].
			(arg2 isString and: [ arg2 isNumberString ])
				ifTrue: [ arg2 := arg2 asNumber ].
			((arg1 isNumber and: [ arg2 isNumber ])
				or: [ arg1 isString and: [ arg2 isString ] ])
				ifTrue: [ ^ arg1 perform: aSymbol with: arg2 ].
			^ false ].
	(#(& |) includes: aSymbol)
		ifTrue: [ ^ arg1 perform: aSymbol with: arg2 ].
	^ arg1 asNumberNoError perform: aSymbol with: arg2 asNumberNoError
]

{ #category : #evaluation }
ScratchScript >> evaluator [
	^ self
]

{ #category : #program }
ScratchScript >> eventBlocks [
	^ blocksBin submorphs select: [:m | m class = EventHatMorph]
]

{ #category : #'object i/o' }
ScratchScript >> fieldsVersion [
	^ 1
]

{ #category : #evaluation }
ScratchScript >> getVar: aString [
	^ self evaluator getVar: aString
]

{ #category : #blocks }
ScratchScript >> hatBlockFromTuple: tuple receiver: scriptOwner [
	| blockClass block eventName |
	blockClass := Smalltalk at: tuple first.
	block := blockClass new scriptOwner: scriptOwner.
	blockClass = EventHatMorph
		ifTrue: [ eventName := tuple at: 2.
			eventName = 'start'
				ifTrue: [ block
						for: 'when start' event: #start;
						scriptOwner: scriptOwner.
					^ block ].
			eventName = 'startup'
				ifTrue: [ block
						forStartupEvent;
						scriptOwner: scriptOwner.
					^ block ].
			eventName = 'setup'
				ifTrue: [ block
						forSetupEvent;
						scriptOwner: scriptOwner.
					^ block ].
			eventName = 'loop'
				ifTrue: [ block
						forLoopEvent;
						scriptOwner: scriptOwner.
					^ block ].
			block eventName: eventName.
			^ block ].
	blockClass = SubHatMorph
		ifTrue: [ block
				subName: (tuple at: 2);
				scriptOwner: scriptOwner.
			^ block ].
	^ block
]

{ #category : #blocks }
ScratchScript >> hatBlockType: blockType [
	| evtName subName |
	'E' = blockType
		ifTrue: [ evtName := ''.
			evtName := project defaultEventName.
			^ EventHatMorph new
				scriptOwner: self;
				eventName: evtName ].
	'G' = blockType
		ifTrue: [ ^ (EventHatMorph new for: 'when start' event: #start)
				scriptOwner: self ].
	'S' = blockType
		ifTrue: [ ^ EventHatMorph new forSetupEvent scriptOwner: self ].
	'T' = blockType
		ifTrue: [ ^ EventHatMorph new forStartupEvent scriptOwner: self ].
	'L' = blockType
		ifTrue: [ ^ EventHatMorph new forLoopEvent scriptOwner: self ].
	'C' = blockType
		ifTrue: [ subName := ''.
			subName := project defaultSubName.
			^ SubHatMorph new
				scriptOwner: self;
				subName: subName ]
]

{ #category : #blocks }
ScratchScript >> hatBlocks [
	^ blocksBin submorphs select: [ :m | m isHatBlock ]
]

{ #category : #'object i/o' }
ScratchScript >> initFieldsFrom: anObjStream version: classVersion [
	self
		initFieldsNamed: #(blocksBin project)
		from: anObjStream
]

{ #category : #initialization }
ScratchScript >> initialize [
	blocksBin := ScratchScriptsMorph new
]

{ #category : #testing }
ScratchScript >> isScriptable [
	^ true
]

{ #category : #testing }
ScratchScript >> isValidSubName: aString [
	self subclassResponsibility
]

{ #category : #'argument menus' }
ScratchScript >> listVarNames [
	self subclassResponsibility
]

{ #category : #blocks }
ScratchScript >> localVarBlockFromTuple: tuple receiver: scriptOwner [
	| varName rcvr |
	varName := tuple at: 2.
	rcvr := scriptOwner.
	^ LocalVarBlockMorph new
		commandSpec: varName;
		receiver: rcvr
]

{ #category : #'argument menus' }
ScratchScript >> mathFunctionNames [
	^ #('abs' 'sqrt' 'sin' 'cos' 'tan' 'asin' 'acos' 'atan' 'ln' 'log' 'e ^' '10 ^')
]

{ #category : #accessing }
ScratchScript >> meOrOwnerThatIsA: aMorph [
	self flag: #ToBeRemove.
	^ project application
]

{ #category : #private }
ScratchScript >> newBlockPaletteMorph [
	^ ScratchBlockPaletteMorph new
		project: project;
		yourself
]

{ #category : #private }
ScratchScript >> newSubMorph [
	^ SubHatMorph new
		scriptOwner: self;
		yourself
]

{ #category : #accessing }
ScratchScript >> objName [
	self subclassResponsibility
]

{ #category : #private }
ScratchScript >> privBlockDef [
	^ blockDef
]

{ #category : #accessing }
ScratchScript >> project [
	^ project
]

{ #category : #accessing }
ScratchScript >> project: aProject [
	project := aProject.
	blocksBin project: project
]

{ #category : #'argument menus' }
ScratchScript >> setupArgBuilder [
	argBuilder := ArgMorphBuilder new.
	self addArgBuilder
]

{ #category : #'block specs' }
ScratchScript >> setupBlockCategory [
	blockDef
		addCategory: 'control' color: (Color h: 41 s: 0.85 v: 0.9);
		addCategory: 'operators' color: (Color h: 93 s: 0.9 v: 0.76);
		addCategory: 'sensing' color: (Color h: 200 s: 0.98 v: 0.86);
		addCategory: 'variables' color: ScratchTheme variableBlockColor;
		addCategory: 'list' color: ScratchTheme listBlockColor
]

{ #category : #'block specs' }
ScratchScript >> setupBlockDef [
	self setupArgBuilder.
	blockDef := ScratchBlockDef new.
	self setupBlockCategory.
	blockDef
		setupFrom: self blocks;
		addUnknownCategories
]

{ #category : #program }
ScratchScript >> setupProgram: aProgram events: aDictionary [
	| subTable |
	subTable := Dictionary new.
	self subBlocks
		do: [ :each | 
			self
				setupSub: each
				program: aProgram
				table: subTable ].
	self eventBlocks
		do: [ :each | 
			self
				setupEvent: each
				program: aProgram
				table: subTable
				events: aDictionary ].
]

{ #category : #'block specs' }
ScratchScript >> specialCommands [
	^ #(#setVar:to:)
]

{ #category : #'object i/o' }
ScratchScript >> stackFromTupleList: tupleList receiver: scriptOwner [
	| stackTop previousBlock block |
	stackTop := previousBlock := nil.
	tupleList
		do: [ :tuple | 
			block := self blockFromTuple: tuple receiver: scriptOwner.
			previousBlock
				ifNil: [ stackTop := block ]
				ifNotNil: [ previousBlock nextBlock: block ].
			previousBlock := block ].
	^ stackTop
]

{ #category : #'object i/o' }
ScratchScript >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(blocksBin project) on: anObjStream.
]

{ #category : #program }
ScratchScript >> subBlocks [
	^ blocksBin submorphs select: [:m | m class = SubHatMorph]
]

{ #category : #accessing }
ScratchScript >> subHatBlockNamed: aString [
	^ self subBlocks detect: [ :each | each subName = aString ] ifNone: [ nil ]
]

{ #category : #testing }
ScratchScript >> subNameInUse: aString [
	^ self subNames includes: aString
]

{ #category : #'argument menus' }
ScratchScript >> subNames [
	^ (self subBlocks collect: #subName) asSet asArray sort
]

{ #category : #accessing }
ScratchScript >> toggleWatcher: aToggleButton for: aBlockMorph [
	self subclassResponsibility
]

{ #category : #'argument menus' }
ScratchScript >> uncoloredArgMorphFor: specString [
	argBuilder ifNil: [ self setupArgBuilder ].
	^ argBuilder uncoloredArgMorphFor: specString
]

{ #category : #'argument menus' }
ScratchScript >> updateListArgFor: aBlock [
	| listVar |
	listVar := self listVarNames
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :l | l first ].
	aBlock argMorphs
		do: [ :each | 
			((each isKindOf: ChoiceArgMorph)
				and: [ each getOptionsSelector = #listVarNames ])
				ifTrue: [ each defaultValue: listVar ] ]
]

{ #category : #accessing }
ScratchScript >> updateWatcher: aToggleButton for: aBlockMorph [
	self subclassResponsibility
]

{ #category : #testing }
ScratchScript >> useList [
	^ true
]

{ #category : #testing }
ScratchScript >> useVariable [
	^ true
]

{ #category : #testing }
ScratchScript >> useVariableWatcher [
	^ true
]

{ #category : #'argument menus' }
ScratchScript >> varNames [
	self subclassResponsibility
]

{ #category : #blocks }
ScratchScript >> variableBlockFromTuple: tuple receiver: scriptOwner [
	"Answer a new block for the given variable reference tuple."

	| varName rcvr selector block arg argBlock |
	varName := tuple at: 2.
	rcvr := scriptOwner.
	(scriptOwner varNames includes: varName)
		ifFalse: [ scriptOwner addVariable: varName ].
	tuple first = #readVariable
		ifTrue: [ ^ VariableBlockMorph new
				commandSpec: varName;
				receiver: rcvr ].
	tuple first = #changeVariable
		ifTrue: [ selector := tuple at: 3.
			"update selector if necessary (backward compatibility):"
			selector = #set:to:
				ifTrue: [ selector := #setVar:to: ].
			block := SetterBlockMorph new receiver: rcvr.
			selector = #setVar:to:
				ifTrue: [ block initSetterForVar: varName ]
				ifFalse: [ block initChangerForVar: varName ].
			arg := tuple at: 4.
			arg isArray
				ifTrue: [ "argument is a block"
					(arg size = 1 and: [ arg first isArray ])
						ifTrue: [ arg := arg first ].
					argBlock := self blockFromTuple: arg receiver: scriptOwner.
					block replaceArgMorph: block expressionArg by: argBlock ]
				ifFalse: [ "argument is a value" block expressionArg defaultValue: arg ].
			^ block ].
	self error: 'unknown variable spec!'
]

{ #category : #variables }
ScratchScript >> variableNameInUse: aString [
	self subclassResponsibility
]

{ #category : #blocks }
ScratchScript >> variablesPage [
	| page y maxX |
	page := self newBlockPaletteMorph
		isForScript: true;
		borderWidth: 0.
	y := 7.
	self useVariable
		ifTrue: [ y := self addGenericVariableBlocksTo: page y: y ].
	self useList
		ifTrue: [ y := self addGenericListBlocksTo: page y: y ].
	maxX := page submorphs inject: 0 into: [ :t :m | t max: m right ].
	page extent: (maxX + 10) @ y.
	^ page
]

{ #category : #blocks }
ScratchScript >> viewerPageForCategory: aCategoryName [
	| bin x y |
	aCategoryName = 'variables'
		ifTrue: [ ^ self variablesPage ].
	bin := self newBlockPaletteMorph
		isForScript: true;
		yourself.
	x := 12.
	y := 10.
	(self blocksFor: aCategoryName)
		do: [ :blockOrSym | 
			blockOrSym = #- | (blockOrSym = #~)
				ifTrue: [ "insert a half space"
					blockOrSym = #-
						ifTrue: [ y := y + 15 ].	"insert a full space"
					blockOrSym = #~
						ifTrue: [ y := y + 5 ] ]
				ifFalse: [ y := self createBlock: blockOrSym atPosition: x @ y onPage: bin ] ].
	^ bin
]

{ #category : #accessing }
ScratchScript >> watcherSelectors [
	^ #()
]
