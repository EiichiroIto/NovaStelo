Class {
	#name : #SteloScript,
	#superclass : #ScratchScript,
	#instVars : [
		'breed'
	],
	#category : #'Stelo-Project'
}

{ #category : #accessing }
SteloScript class >> allBlockNames [
	"self allBlockNames"
	| list |
	list := Set new.
	self
		subclassesDo: [ :each | 
			(each new blocks reject: [ :each2 | each2 isString ])
				do: [ :each3 | list add: each3 first ] ].
	^ list asArray sorted
]

{ #category : #'argument menus' }
SteloScript >> addArgBuilder [
	super addArgBuilder.
	argBuilder
		addNumberExpressArg: $c
			selector: #colorMenu
			target: nil
			initialExpression: '15';
		addChoiceArg: $o selector: #observerVarNamesMenu;
		addChoiceArg: $p selector: #patchVarNamesMenu;
		addChoiceArg: $t selector: #turtleVarNamesMenu
]

{ #category : #variables }
SteloScript >> addList: aString [
	| vno |
	vno := breed addList: aString.
	self project addList: aString var: vno breed: breed breedNo
]

{ #category : #variables }
SteloScript >> addVariable: aString [
	| vno |
	vno := breed addVariable: aString.
	self project addVariable: aString var: vno breed: breed breedNo
]

{ #category : #'block specs' }
SteloScript >> blocks [
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

	^ super blocks, #(
		'basic'
			('kill %n of %m'				-	kill:breed: 0 '')
		'sensing'
			('x %n y %n'					r	patchAtX:y:	0 0)
			-
			('turtles %m count'		r turtlesCount: '')
			('screen width'				r 	screenWidth)
			('screen height'				r 	screenHeight)
			('ticks'							r 	ticks)
	)
]

{ #category : #accessing }
SteloScript >> breed [
	^ breed
]

{ #category : #accessing }
SteloScript >> breed: aBreed [
	breed := aBreed
]

{ #category : #accessing }
SteloScript >> breedNo [
	^ breed breedNo
]

{ #category : #'block specs' }
SteloScript >> colorBlocks [
	^ #(
		'color'
			('color'					r	getColor)
			('set color to %c'			- setColor: 15)
			('scale %v color %c from %n to %n'  - #scaleValue:color:from:to: '' 15 0 100 )
			-
			('random'				r	colorRandom)
			('black'				r	colorBlack)
			('gray'				r	colorGray)
			('white'				r	colorWhite)
			('red'					r	colorRed)
			('orange'			r	colorOrange)
			('brown'				r	colorBrown)
			('yellow'			r	colorYellow)
			('green'				r	colorGreen)
			('lime'				r	colorLime)
			('turquoise'		r	colorTurquoise)
			('cyan'				r	colorCyan)
			('sky'					r	colorSky)
			('blue'				r	colorBlue)
			('purple'			r	colorPurple)
			('magenta'			r	colorMagenta)
			('pink'				r	colorPink)
	)
]

{ #category : #'argument menus' }
SteloScript >> colorMenu [
	^ SColorList colorNames collect: [ :each | Array with: each with: (SColorList perform: each) ].
]

{ #category : #blocks }
SteloScript >> defaultArgsFor: blockSpec [
	| sel turtles lists args |
	sel := (blockSpec at: 3) asSymbol.
	args := blockSpec copyFrom: 4 to: blockSpec size.
	turtles := self project scriptsForMenu.
	turtles notEmpty
		ifTrue: [ (#(turtlesCount: clearTurtle:) includes: sel)
				ifTrue: [ ^ args
						at: 1 put: turtles first;
						yourself ].
			(#(#createTurtleSize:breedId: #kill:breed:) includes: sel)
				ifTrue: [ ^ args
						at: 2 put: turtles first;
						yourself ] ].
	lists := self listVarNames.
	lists notEmpty
		ifTrue: [ (#(clearList: lineCountOfList: #list:contains:) includes: sel)
				ifTrue: [ ^ args
						at: 1 put: lists first;
						yourself ].
			(#(#append:toList: #deleteLine:ofList: #getLine:ofList: #setLine:ofList:to:)
				includes: sel)
				ifTrue: [ ^ args
						at: 2 put: lists first;
						yourself ] ].
	^ super defaultArgsFor: blockSpec
]

{ #category : #variables }
SteloScript >> deleteList: aString [
	self deleteVariable: aString
]

{ #category : #variables }
SteloScript >> deleteVariable: aString [
	breed deleteVariable: aString
]

{ #category : #processes }
SteloScript >> evaluateFor: aTopBlock [
	^ nil
]

{ #category : #'object i/o' }
SteloScript >> fieldsVersion [
	^ 1
]

{ #category : #'object i/o' }
SteloScript >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self
		initFieldsNamed: #(breed)
		from: anObjStream
]

{ #category : #testing }
SteloScript >> isObserver [
	^ false
]

{ #category : #testing }
SteloScript >> isPatches [
	^ false
]

{ #category : #testing }
SteloScript >> isTurtles [
	^ false
]

{ #category : #testing }
SteloScript >> isValidSubName: aString [

	^ aString allSatisfy: [ :each | each isAlphaNumeric ]
]

{ #category : #'argument menus' }
SteloScript >> listVarNames [
	^ breed userDefinedListNames sort
]

{ #category : #accessing }
SteloScript >> objName [
	^ 'None'
]

{ #category : #'block specs' }
SteloScript >> observerBlocks [
	^ #(
		'sensing'
			('observer''s %o'					r	getObserverVar: '')
	)
]

{ #category : #accessing }
SteloScript >> observerVarId [
	^ self project observer varId
]

{ #category : #'argument menus' }
SteloScript >> observerVarNamesMenu [
	^ self project observerVarNamesMenu
]

{ #category : #accessing }
SteloScript >> patchVarId [
	^ self project patches varId
]

{ #category : #'argument menus' }
SteloScript >> patchVarNamesMenu [
	^ self project patchVarNamesMenu
]

{ #category : #'block specs' }
SteloScript >> setupBlockCategory [
	super setupBlockCategory.
	blockDef
		addCategory: 'basic' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'color' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'pen' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'patch' color: (Color h: 296 s: 0.66 v: 0.85)
]

{ #category : #program }
SteloScript >> setupEvent: aHatBlock program: aProgram table: aDictionary events: aDictionary2 [
	| code addr |
	aDictionary2
		at: aHatBlock eventName asSymbol
		ifPresent: [ :eventNo | 
			addr := aProgram nextAddress.
			code := project newCode
				startAddress: addr;
				subTable: aDictionary;
				parse: aHatBlock target: self.
			aProgram
				addCode: code;
				addEntryPoint: addr eventNo: eventNo breedNo: self breedNo ]
]

{ #category : #program }
SteloScript >> setupSub: aHatBlock program: aProgram table: aDictionary [
	| code addr |
	addr := aProgram nextAddress.
	code := project newCode
		startAddress: addr;
		subTable: aDictionary;
		parse: aHatBlock target: self.
	aProgram addCode: code.
	aDictionary at: aHatBlock subName put: addr
]

{ #category : #'object i/o' }
SteloScript >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(breed) on: anObjStream.
]

{ #category : #private }
SteloScript >> toggleWatcher: aToggleButton for: aBlockMorph [
	
]

{ #category : #'argument menus' }
SteloScript >> turtleVarNamesMenu [
	^ self project turtleVarNamesMenu
]

{ #category : #private }
SteloScript >> updateWatcher: aToggleButton for: aBlockMorph [
	
]

{ #category : #testing }
SteloScript >> useList [
	^ false
]

{ #category : #testing }
SteloScript >> useVariableWatcher [
	^ false
]

{ #category : #accessing }
SteloScript >> varId [
	^ breed varId
]

{ #category : #variables }
SteloScript >> varNames [
	^ breed userDefinedVarNames
]

{ #category : #accessing }
SteloScript >> varNoFor: vno breed: bno [
	^ project varNoFor: vno breed: bno
]

{ #category : #variables }
SteloScript >> variableNameInUse: aString [
	^ breed variableNameInUse: aString
]

{ #category : #'block specs' }
SteloScript >> variablesBlocks [
	^ #(
		'list'
			('clear %L'											-	clearList: 'list')
			('add %n to %L'									-	append:toList: 10 'list')
			('delete %n of %L'								-	deleteLine:ofList: 1 'list')
			('replace item %n of %L with %n'		-	setLine:ofList:to: 1 'list' 10)
			-
			('item %n of %L'									r	getLine:ofList: 1 'list')
			('length of %L'									r	lineCountOfList: 'list')
			('%L contains %n'								b	list:contains: 'list' 10)
	)
]
