Class {
	#name : #ScratchScript,
	#superclass : #Object,
	#instVars : [
		'blocksBin',
		'project',
		'blockMorphBuilder',
		'argMorphBuilder'
	],
	#category : #'FromScratch-Project'
}

{ #category : #utilities }
ScratchScript class >> printBlockSpecsFrom: aCollection [

	"ScratchScript printBlockSpecsFrom: ScratchScript new blocks."

	aCollection do: [ :each | 
		each isString ifTrue: [ 
			(each = '-'
				 ifTrue: [ 'addSeparator;' ]
				 ifFalse: [ 'addCategory: ''' , each , ''';' ]) traceCr ].
		each isArray ifTrue: [ 
			(each second
				 caseOf: { 
						 ([ #- ] -> [ 
						  'addCommand: ''' , each first , ''' selector: #' , each third
						  , ' arguments: ' , (each copyFrom: 4 to: each size) asString
						  , ';' ]).
						 ([ #r ] -> [ 
						  'addReporter: ''' , each first , ''' selector: #' , each third
						  , ' arguments: ' , (each copyFrom: 4 to: each size) asString
						  , ';' ]).
						 ([ #b ] -> [ 
						  'addBooleanReporter: ''' , each first , ''' selector: #'
						  , each third , ' arguments: '
						  , (each copyFrom: 4 to: each size) asString , ';' ]).
						 ([ #c ] -> [ 
						  'addCBlock: ''' , each first , ''' selector: #' , each third
						  , ' arguments: ' , (each copyFrom: 4 to: each size) asString
						  , ';' ]).
						 ([ #L ] -> [ 
						  'addHatBlock: ''' , each first , ''' type: #' , each second
						  , ' arguments: ' , (each copyFrom: 3 to: each size) asString
						  , ';' ]).
						 ([ #E ] -> [ 
						  'addHatBlock: ''' , each first , ''' type: #' , each second
						  , ' arguments: ' , (each copyFrom: 3 to: each size) asString
						  , ';' ]).
						 ([ #S ] -> [ 
						  'addHatBlock: ''' , each first , ''' type: #' , each second
						  , ' arguments: ' , (each copyFrom: 3 to: each size) asString
						  , ';' ]).
						 ([ #T ] -> [ 
						  'addHatBlock: ''' , each first , ''' type: #' , each second
						  , ' arguments: ' , (each copyFrom: 3 to: each size) asString
						  , ';' ]) }
				 otherwise: [ each ]) traceCr ] ]
]

{ #category : #'ston-core' }
ScratchScript class >> stonAllInstVarNames [
	^ #(blocksBin project)
]

{ #category : #'argument menus' }
ScratchScript >> addArgBuilder [

	self subclassResponsibility
]

{ #category : #'block specs' }
ScratchScript >> addBlockSpecs [

	self subclassResponsibility
]

{ #category : #api }
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

{ #category : #'block building' }
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
	page addMorph: (addButton
			 target: project application;
			 arguments: { self };
			 position: x @ y).
	y := addButton bottom + 3.
	self listVarNames isEmpty ifTrue: [ ^ y ].
	page addMorph: (deleteButton
			 target: project application;
			 arguments: { self };
			 position: x @ y).
	y := deleteButton bottom + 10.
	"y := (self addListReportersTo: page x: x y: y) + 10."
	(self blocksFor: 'list') do: [ :each | 
		each isBlockMorph
			ifTrue: [ 
				self updateListArgFor: each.
				y := self createBlock: each atPosition: x @ y onPage: page.
				page submorphs last color: ScratchTheme listBlockColor ]
			ifFalse: [ y := y + 15 ] ].
	^ y
]

{ #category : #'block building' }
ScratchScript >> addGenericVariableBlocksTo: page x: x y: startY [

	"Add the generic variable blocks to the given page starting at the given y offset. Answer the new y."

	| y vName varBlocks |
	y := startY.

	"pick a default variable name"
	self varNames isEmpty ifTrue: [ ^ y ].
	vName := self varNames first.
	varBlocks := OrderedCollection new
		             add: (blockMorphBuilder setVarBlockFor: vName);
		             add: (blockMorphBuilder changeVarBlockFor: vName);
		             yourself.
	(blockMorphBuilder blocksFor: 'variables') do: [ :b | 
		b defaultArgs: (Array with: vName).
		varBlocks add: b ].
	varBlocks do: [ :b | 
		page addMorph: (b position: x @ y).
		y := b bottom + 3 ].
	^ y
]

{ #category : #'block building' }
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
				target: project application;
				arguments: {self};
				position: x @ startY).
	y := addButton bottom + 3.
	self varNames notEmpty
		ifTrue: [ page
				addMorph:
					(deleteButton
						target: project application;
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

{ #category : #'block building' }
ScratchScript >> addSubBlock: aPoint name: aString [

	| morph |
	morph := blockMorphBuilder subHatBlockFor: aString.
	morph position: aPoint.
	blocksBin addMorph: morph
]

{ #category : #variables }
ScratchScript >> addVariable: aString [
	self subclassResponsibility
]

{ #category : #'block building' }
ScratchScript >> addVariableReportersTo: page x: x y: startY [

	| y b watcherButton yOffset |
	y := startY.
	self varNames do: [ :vName | 
		b := blockMorphBuilder variableBlockFor: vName.
		watcherButton := self createToggleButtonFor: b.
		yOffset := b fullBounds height - watcherButton height // 2.
		self useVariableWatcher ifTrue: [ 
			page addMorph: (watcherButton position: x @ (y + yOffset)) ].
		page addMorph: (b position: x + watcherButton width + 4 @ y).
		y := y + b height + 3 ].
	^ y
]

{ #category : #accessing }
ScratchScript >> allHatBlocks [

	^ self subHatBlocks , self eventHatBlocks , self startHatBlocks
]

{ #category : #accessing }
ScratchScript >> argMorphBuilder [

	^ argMorphBuilder
]

{ #category : #accessing }
ScratchScript >> argMorphBuilder: anObject [

	argMorphBuilder := anObject
]

{ #category : #'block building' }
ScratchScript >> argMorphFor: aCharacter [

	^ argMorphBuilder argMorphFor: aCharacter
]

{ #category : #'block specs' }
ScratchScript >> blockCategories [
	^ blockMorphBuilder blockCategories
]

{ #category : #'block specs' }
ScratchScript >> blockColorFor: aCategory [
	^ blockMorphBuilder blockColorFor: aCategory
]

{ #category : #'block building' }
ScratchScript >> blockFromTuple: anArray [

	^ blockMorphBuilder blockFromTuple: anArray
]

{ #category : #accessing }
ScratchScript >> blockMorphBuilder [

	^ blockMorphBuilder
]

{ #category : #accessing }
ScratchScript >> blockMorphBuilder: anObject [

	blockMorphBuilder := anObject
]

{ #category : #'block building' }
ScratchScript >> blockMorphsForWriting [

	^ blocksBin submorphs select: [ :m | m respondsTo: #tupleSequence ]
]

{ #category : #'block specs' }
ScratchScript >> blockSpecAt: aSymbol [
	^ blockMorphBuilder blockSpecAt: aSymbol
]

{ #category : #accessing }
ScratchScript >> blocksBin [
	^ blocksBin
]

{ #category : #accessing }
ScratchScript >> blocksBin: anObject [

	blocksBin := anObject
]

{ #category : #'block specs' }
ScratchScript >> blocksFor: aCategory [
	^ blockMorphBuilder blocksFor: aCategory
]

{ #category : #'block specs' }
ScratchScript >> cBlockSelectors [

	^ #( doIf doRepeat doUntil doForever doWhile doIterate )
]

{ #category : #'block building' }
ScratchScript >> cleanUp [
	blocksBin cleanUp
]

{ #category : #'block building' }
ScratchScript >> convertEventHatTuple: anArray [

	| selector |
	anArray first = #EventHatMorph ifTrue: [ 
		selector := anArray second asSymbol.
		^ (self startHatBlockNames includes: selector)
			  ifTrue: [ Array with: selector ]
			  ifFalse: [ Array with: #event: with: selector ] ].
	anArray first = #SubHatMorph ifTrue: [ 
		^ Array with: #sub: with: anArray second ].
	^ anArray
]

{ #category : #'block building' }
ScratchScript >> convertStacksToTuples [

	"Convert my blocks bin from a morph containing block stack into a collection of (<point>, <tuple>) pairs the represent the same stacks in compact, language-independent form."

	blocksBin isArray ifTrue: [ ^ self ].
	blocksBin := self blockMorphsForWriting collect: [ :blockM | 
		             Array
			             with: blockM position - blocksBin position
			             with: blockM tupleSequence ]
]

{ #category : #'block building' }
ScratchScript >> convertTuplesToStacks [

	| tuplesList stack |
	blocksBin isArray ifFalse: [ ^ self ].
	tuplesList := blocksBin.
	blocksBin := self newScriptsMorph
		             project: project;
		             yourself.
	tuplesList do: [ :pair | 
		stack := blockMorphBuilder stackFromTupleList: pair second.
		stack position: pair first.
		blocksBin addMorph: stack ]
]

{ #category : #'block building' }
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

{ #category : #'block building' }
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

{ #category : #'block building' }
ScratchScript >> defaultArgsFor: blockSpec [

	| defaultArgs |
	defaultArgs := blockSpec arguments copy.
	(#( broadcast: doBroadcastAndWait ) includes: blockSpec selector) 
		ifTrue: [ defaultArgs := Array with: project defaultEventName ].
	^ defaultArgs
]

{ #category : #accessing }
ScratchScript >> defaultEventName [

	^ project defaultEventName
]

{ #category : #accessing }
ScratchScript >> defaultSubName [

	^ project defaultSubName
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
ScratchScript >> evaluateBlock: aTopBlock [

	^ self evaluator perform: aTopBlock selector withArguments: aTopBlock coerceArgs
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
ScratchScript >> evaluator [
	^ self
]

{ #category : #accessing }
ScratchScript >> eventHatBlocks [

	^ blocksBin submorphs select: [ :m | m class = EventHatMorph ]
]

{ #category : #'object i/o' }
ScratchScript >> fieldsVersion [
	^ 1
]

{ #category : #api }
ScratchScript >> fixScriptBeforeWriting [

	blocksBin allMorphsDo: [ :each | 
		each isBlockMorph ifTrue: [ each stopProcess ] ]
]

{ #category : #api }
ScratchScript >> fixUnsavedFields [
	blocksBin allMorphs
		do: [ :each | 
			each isArgMorph
				and: [ each isExpressionArg
						ifTrue: [ each loseKeyboardFocus ] ] ]
]

{ #category : #'block specs' }
ScratchScript >> foreverBlockSelectors [

	^ #( doForever doForeverIf )
]

{ #category : #evaluation }
ScratchScript >> getVar: aString [
	^ self evaluator getVar: aString
]

{ #category : #'block specs' }
ScratchScript >> getVarSelectors [

	^ #( getVar )
]

{ #category : #accessing }
ScratchScript >> hatBlocks [
	^ blocksBin submorphs select: [ :m | m isHatBlock ]
]

{ #category : #'block specs' }
ScratchScript >> ifElseBlockSelectors [

	^ #( doIfElse )
]

{ #category : #'object i/o' }
ScratchScript >> initFieldsFrom: anObjStream version: classVersion [
	self
		initFieldsNamed: #(blocksBin project)
		from: anObjStream
]

{ #category : #initialization }
ScratchScript >> initialize [

	blocksBin := self newScriptsMorph
]

{ #category : #testing }
ScratchScript >> isValidSubName: aString [
	self subclassResponsibility
]

{ #category : #'argument menus' }
ScratchScript >> listVarNames [
	self subclassResponsibility
]

{ #category : #'block specs' }
ScratchScript >> loopBlockSelectors [

	^ #( doForever doForeverIf doRepeat doUntil )
]

{ #category : #'instance creation' }
ScratchScript >> newArgMorphBuilder [

	^ ArgMorphBuilder new
]

{ #category : #'instance creation' }
ScratchScript >> newBlockMorphBuilder [

	^ BlockMorphBuilder new
		  script: self;
		  yourself
]

{ #category : #'instance creation' }
ScratchScript >> newBlockPaletteMorph [
	^ ScratchBlockPaletteMorph new
		project: project;
		yourself
]

{ #category : #'instance creation' }
ScratchScript >> newScriptsMorph [

	^ ScratchScriptsMorph new
]

{ #category : #accessing }
ScratchScript >> objName [
	self subclassResponsibility
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

{ #category : #'block specs' }
ScratchScript >> setVarSelectors [

	^ #( setVar:to: changeVar:by: )
]

{ #category : #'block specs' }
ScratchScript >> setupBlockCategory [

	blockMorphBuilder
		setCategory: 'control' color: (Color h: 41 s: 0.85 v: 0.9);
		setCategory: 'operators' color: (Color h: 93 s: 0.9 v: 0.76);
		setCategory: 'sensing' color: (Color h: 200 s: 0.98 v: 0.86);
		setCategory: 'variables' color: ScratchTheme variableBlockColor;
		setCategory: 'list' color: ScratchTheme listBlockColor
]

{ #category : #'block specs' }
ScratchScript >> setupBlockSpecs [

	argMorphBuilder := self newArgMorphBuilder.
	blockMorphBuilder := self newBlockMorphBuilder.
	self addArgBuilder.
	self setupBlockCategory.
	self addBlockSpecs
]

{ #category : #'block specs' }
ScratchScript >> specialCommandSelectors [

	^ #( #setVar:to: )
]

{ #category : #'block specs' }
ScratchScript >> startHatBlockNames [

	self subclassResponsibility
]

{ #category : #accessing }
ScratchScript >> startHatBlocks [

	^ blocksBin submorphs select: [ :m | m class = StartHatMorph ]
]

{ #category : #'block specs' }
ScratchScript >> stopBlockSelectors [

	^ #( stopThread stopAll return: break continue doReturn )
]

{ #category : #'object i/o' }
ScratchScript >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(blocksBin project) on: anObjStream.
]

{ #category : #accessing }
ScratchScript >> subHatBlockNamed: aString [
	^ self subHatBlocks detect: [ :each | each subName = aString ] ifNone: [ nil ]
]

{ #category : #accessing }
ScratchScript >> subHatBlocks [
	^ blocksBin submorphs select: [:m | m class = SubHatMorph]
]

{ #category : #testing }
ScratchScript >> subNameInUse: aString [
	^ self subNames includes: aString
]

{ #category : #'argument menus' }
ScratchScript >> subNames [
	^ (self subHatBlocks collect: #subName) asSet asArray sort
]

{ #category : #accessing }
ScratchScript >> toggleWatcher: aToggleButton for: aBlockMorph [
	self subclassResponsibility
]

{ #category : #'argument menus' }
ScratchScript >> uncoloredArgMorphFor: specString [

	"argBuilder ifNil: [ self setupArgBuilder ]."
	^ argMorphBuilder argMorphFor: specString second
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

{ #category : #'block specs' }
ScratchScript >> variableBlockSelectors [

	^ #( readVariable changeVariable )
]

{ #category : #variables }
ScratchScript >> variableNameInUse: aString [
	self subclassResponsibility
]

{ #category : #'block building' }
ScratchScript >> variablesPage [

	| page y maxX |
	page := self newBlockPaletteMorph
		        borderWidth: 0;
		        yourself.
	y := 7.
	self useVariable ifTrue: [ 
		y := self addGenericVariableBlocksTo: page y: y ].
	self useList ifTrue: [ y := self addGenericListBlocksTo: page y: y ].
	maxX := page submorphs inject: 0 into: [ :t :m | t max: m right ].
	page extent: maxX + 10 @ y.
	^ page
]

{ #category : #'block building' }
ScratchScript >> viewerPageForCategory: aCategoryName [

	| bin x y |
	aCategoryName = 'variables' ifTrue: [ ^ self variablesPage ].
	bin := self newBlockPaletteMorph.
	x := 12.
	y := 10.
	(self blocksFor: aCategoryName) do: [ :each | 
		y := each isBlockMorph
			     ifTrue: [ 
			     self createBlock: each atPosition: x @ y onPage: bin ]
			     ifFalse: [ 
				     each isSeparator
					     ifTrue: [ y + 15 ]
					     ifFalse: [ self error ] ] ].
	^ bin
]

{ #category : #accessing }
ScratchScript >> watcherSelectors [
	^ #()
]
