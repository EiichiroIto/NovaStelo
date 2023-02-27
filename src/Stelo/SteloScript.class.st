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

	argMorphBuilder
		addBooleanArg: $b;
		addEventTitleArg: $e;
		addChoiceArg: $f
		options:
			#( 'abs' 'sqrt' 'sin' 'cos' 'tan' 'asin' 'acos' 'atan' 'ln' 'log'
			   'e ^' '10 ^' )
		initialChoice: 'sqrt';
		addLocalVarArg: $l;
		addChoiceArg: $L selector: #listVarNames;
		addSpriteArg: $m;
		addNumberExpressArg: $n initialExpression: '10';
		addChoiceArg: $S selector: #subNames;
		addStringExpressArg: $s;
		addChoiceArg: $v selector: #varNames;
		addNumberExpressArg: $c selector: #colorMenu target: nil initialExpression: '15';
		addChoiceArg: $o selector: #observerVarNamesMenu;
		addChoiceArg: $p selector: #patchVarNamesMenu;
		addChoiceArg: $t selector: #turtleVarNamesMenu
]

{ #category : #'block specs' }
SteloScript >> addBasicBlocks [

	blockMorphBuilder
		addCategory: 'basic';
		addCommand: 'kill %n of %m' selector: #kill:breed: arguments: #( 0 '' )
]

{ #category : #'block specs' }
SteloScript >> addBlockSpecs [

	self
		addBasicBlocks;
		addControlBlocks;
		addOperatorsBlocks;
		addSensingBlocks
]

{ #category : #'block specs' }
SteloScript >> addColorBlocks [

	blockMorphBuilder
		addCategory: 'color';
		addReporter: 'color' selector: #getColor;
		addCommand: 'set color to %c' selector: #setColor: arguments: #( 15 );
		addCommand: 'scale %v color %c from %n to %n' selector: #scaleValue:color:from:to: arguments: #( '' 15 0 100 )
]

{ #category : #'block specs' }
SteloScript >> addConstantColorBlocks [

	blockMorphBuilder
		addCategory: 'color';
		addSeparator;
		addReporter: 'random' selector: #colorRandom;
		addReporter: 'black' selector: #colorBlack;
		addReporter: 'gray' selector: #colorGray;
		addReporter: 'white' selector: #colorWhite;
		addReporter: 'red' selector: #colorRed;
		addReporter: 'orange' selector: #colorOrange;
		addReporter: 'brown' selector: #colorBrown;
		addReporter: 'yellow' selector: #colorYellow;
		addReporter: 'green' selector: #colorGreen;
		addReporter: 'lime' selector: #colorLime;
		addReporter: 'turquoise' selector: #colorTurquoise;
		addReporter: 'cyan' selector: #colorCyan;
		addReporter: 'sky' selector: #colorSky;
		addReporter: 'blue' selector: #colorBlue;
		addReporter: 'purple' selector: #colorPurple;
		addReporter: 'magenta' selector: #colorMagenta;
		addReporter: 'pink' selector: #colorPink
]

{ #category : #'block specs' }
SteloScript >> addControlBlocks [

	blockMorphBuilder
		addCategory: 'control';
		addStartHatBlock: 'when loop' selector: #loop;
		addEventHatBlock: 'when I receive' selector: #event: eventName: '';
		addSeparator;
		addCBlock: 'repeat %n' selector: #doRepeat arguments: #( 10 );
		addSeparator;
		addCommand: 'broadcast %e' selector: #broadcast:;
		addCommand: 'call %S' selector: #callSub: arguments: #( '' );
		addCommand: 'return %n' selector: #return: arguments: #( 0 );
		addSeparator;
		addCBlock: 'if %b' selector: #doIf arguments: #(  );
		addCBlock: 'if %b' selector: #doIfElse arguments: #(  );
		addCBlock: 'repeat until %b' selector: #doUntil arguments: #(  );
		addSeparator;
		addCommand: 'stop script' selector: #stopThread;
		addCommand: 'stop all' selector: #stopAll
]

{ #category : #variables }
SteloScript >> addList: aString [
	| vno |
	vno := breed addList: aString.
	project addList: aString var: vno breed: breed breedNo
]

{ #category : #'block specs' }
SteloScript >> addListBlocks [

	blockMorphBuilder
		addCategory: 'list';
		addCommand: 'clear %L' selector: #clearList: arguments: #( 'list' );
		addCommand: 'add %n to %L' selector: #append:toList: arguments: #( 10 'list' );
		addCommand: 'delete %n of %L' selector: #deleteLine:ofList: arguments: #( 1 'list' );
		addCommand: 'replace item %n of %L with %n' selector: #setLine:ofList:to: arguments: #( 1 'list' 10 );
		addSeparator;
		addReporter: 'item %n of %L' selector: #getLine:ofList: arguments: #( 1 'list' );
		addReporter: 'length of %L' selector: #lineCountOfList: arguments: #( 'list' );
		addBooleanReporter: '%L contains %n' selector: #list:contains: arguments: #( 'list' 10 )
]

{ #category : #'block specs' }
SteloScript >> addObserverBlocks [

	blockMorphBuilder
		addCategory: 'control';
		addStartHatBlock: 'when setup' selector: #setup;

		addCategory: 'patch';
		addReporter: 'patch color at %n' selector: #getPatchColorAt: arguments: #( 0 );
		addCommand: 'set patch color at %n to %c' selector: #setPatchColorAt:to: arguments: #( 0 15 );
		
		addCategory: 'sensing';
		addReporter: 'observer''s %o' selector: #getObserverVar: arguments: #( '' );

		addCategory: 'basic';
		addCommand: 'change observer''s %o by %n' selector: #changeObserverVar:by: arguments: #( '' 1 )
]

{ #category : #'block specs' }
SteloScript >> addOperatorsBlocks [

	blockMorphBuilder
		addCategory: 'operators';
		addReporter: '%n + %n' selector: #plus:and: arguments: #( 1 2 );
		addReporter: '%n - %n' selector: #minus:with: arguments: #( 1 2 );
		addReporter: '%n * %n' selector: #multiply:and: arguments: #( 1 2 );
		addReporter: '%n / %n' selector: #divide:by: arguments: #( 1 2 );
		addReporter: '- %n' selector: #negated: arguments: #( 1 );
		addSeparator;
		addReporter: 'pick random %n to %n' selector: #randomFrom:to: arguments: #( 1 10 );
		addSeparator;
		addBooleanReporter: '%s < %s' selector: #less:than: arguments: #( '' '' );
		addBooleanReporter: '%s <= %s' selector: #lessEqual:than: arguments: #( '' '' );
		addBooleanReporter: '%s = %s' selector: #equal:to: arguments: #( '' '' );
		addBooleanReporter: '%s >= %s' selector: #moreEqual:than: arguments: #( '' '' );
		addBooleanReporter: '%s > %s' selector: #more:than: arguments: #( '' '' );
		addBooleanReporter: '%n between %n and %n' selector: #is:between:and: arguments: #( 50 0 100 );
		addSeparator;
		addBooleanReporter: '%b and %b' selector: #and:with: arguments: #( '' '' );
		addBooleanReporter: '%b or %b' selector: #or:with: arguments: #( '' '' );
		addBooleanReporter: 'not %b' selector: #not: arguments: #( '' '' );
		addSeparator;
		addReporter: '%n mod %n' selector: #mod:by: arguments: #( 7 3 );
		addReporter: 'round %n' selector: #rounded: arguments: #( 1.5 );
		addReporter: 'truncate %n' selector: #truncated: arguments: #( 1.5 );
		addSeparator;
		addReporter: '%f of %n' selector: #computeFunction:of: arguments: #( 'sqrt' 10 )
]

{ #category : #'block specs' }
SteloScript >> addSensingBlocks [

	blockMorphBuilder
		addCategory: 'sensing';
		addReporter: 'x %n y %n' selector: #patchAtX:y: arguments: #( 0 0 );
		addReporter: 'turtles %m count' selector: #turtlesCount: arguments: #( '' );
		addSeparator;
		addReporter: 'returned value' selector: #returnValue;
		addReporter: 'screen width' selector: #screenWidth;
		addReporter: 'screen height' selector: #screenHeight;
		addReporter: 'ticks' selector: #ticks
]

{ #category : #variables }
SteloScript >> addVariable: aString [
	| vno |
	vno := breed addVariable: aString.
	project addVariable: aString var: vno breed: breed breedNo
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

{ #category : #'argument menus' }
SteloScript >> colorMenu [
	^ ColorList colorNames collect: [ :each | Array with: each localized with: (ColorList perform: each) ].
]

{ #category : #blocks }
SteloScript >> defaultArgsFor: blockSpec [
	| selector turtles lists args |
	selector := blockSpec selector.
	args := blockSpec arguments copy.
	turtles := project scriptsForMenu.
	turtles notEmpty
		ifTrue: [ (#(turtlesCount: clearTurtle:) includes: selector)
				ifTrue: [ ^ args
						at: 1 put: turtles first;
						yourself ].
			(#(#createTurtleSize:breedId: #kill:breed:) includes: selector)
				ifTrue: [ ^ args
						at: 2 put: turtles first;
						yourself ] ].
	lists := self listVarNames.
	lists notEmpty
		ifTrue: [ (#(clearList: lineCountOfList: #list:contains:) includes: selector)
				ifTrue: [ ^ args
						at: 1 put: lists first;
						yourself ].
			(#(#append:toList: #deleteLine:ofList: #getLine:ofList: #setLine:ofList:to:)
				includes: selector)
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

{ #category : #evaluation }
SteloScript >> evaluateBlock: aTopBlock [
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

{ #category : #'argument menus' }
SteloScript >> observerVarNamesMenu [
	^ project observerVarNamesMenu
]

{ #category : #'argument menus' }
SteloScript >> patchVarNamesMenu [
	^ project patchVarNamesMenu
]

{ #category : #'block specs' }
SteloScript >> setupBlockCategory [

	blockMorphBuilder
		setCategory: 'control' color: (Color h: 41 s: 0.85 v: 0.9);
		setCategory: 'operators' color: (Color h: 93 s: 0.9 v: 0.76);
		setCategory: 'sensing' color: (Color h: 200 s: 0.98 v: 0.86);
		setCategory: 'variables' color: ScratchTheme variableBlockColor;
		setCategory: 'list' color: ScratchTheme listBlockColor;
		setCategory: 'basic' color: (Color h: 225 s: 0.65 v: 0.83);
		setCategory: 'color' color: (Color h: 264 s: 0.62 v: 0.89);
		setCategory: 'pen' color: (Color h: 165 s: 1 v: 0.63);
		setCategory: 'patch' color: (Color h: 296 s: 0.66 v: 0.85)
]

{ #category : #program }
SteloScript >> setupEvent: aHatBlock program: aProgram table: aDictionary events: aDictionary2 [

	| code addr |
	aDictionary2
		at: aHatBlock eventName asSymbol
		ifPresent: [ :eventNo | 
			addr := aProgram nextAddress.
			code := project newCode
				        address: addr;
				        subTable: aDictionary;
				        script: self;
				        parseBlock: aHatBlock.
			aProgram
				addCode: code;
				addEntryPoint: addr eventNo: eventNo breedNo: self breedNo ]
]

{ #category : #program }
SteloScript >> setupProgram: aProgram events: aDictionary [

	| subTable |
	subTable := Dictionary new.
	self subHatBlocks do: [ :each | 
		self setupSub: each program: aProgram table: subTable ].
	self eventHatBlocks do: [ :each | 
		self
			setupEvent: each
			program: aProgram
			table: subTable
			events: aDictionary ].
	self startHatBlocks do: [ :each | 
		self
			setupStart: each
			program: aProgram
			table: subTable
			events: aDictionary ]
]

{ #category : #program }
SteloScript >> setupStart: aHatBlock program: aProgram table: aDictionary events: aDictionary2 [

	| code addr |
	aDictionary2 at: aHatBlock selector ifPresent: [ :eventNo | 
		addr := aProgram nextAddress.
		code := project newCode
			        address: addr;
			        subTable: aDictionary;
			        script: self;
			        parseBlock: aHatBlock.
		aProgram
			addCode: code;
			addEntryPoint: addr eventNo: eventNo breedNo: self breedNo ]
]

{ #category : #program }
SteloScript >> setupSub: aHatBlock program: aProgram table: aDictionary [

	| code addr |
	addr := aProgram nextAddress.
	code := project newCode
		        address: addr;
		        subTable: aDictionary;
		        script: self;
		        parseBlock: aHatBlock.
	aProgram addCode: code.
	aDictionary at: aHatBlock subName put: addr
]

{ #category : #'block specs' }
SteloScript >> startHatBlockNames [

	^ #( startup setup loop )
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
	^ project turtleVarNamesMenu
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

{ #category : #variables }
SteloScript >> varNames [
	^ breed userDefinedVarNames
]

{ #category : #accessing }
SteloScript >> varNoFor: aString [

	^ breed varNoFor: aString
]

{ #category : #accessing }
SteloScript >> varNoFor: vno breed: bno [

	^ project varNoFor: vno breed: bno
]

{ #category : #variables }
SteloScript >> variableNameInUse: aString [
	^ breed variableNameInUse: aString
]
