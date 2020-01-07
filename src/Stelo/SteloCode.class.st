Class {
	#name : #SteloCode,
	#superclass : #ScratchCode,
	#category : #'Stelo-Process'
}

{ #category : #accessing }
SteloCode class >> addCommand: aSymbol [
	UsedCommands add: aSymbol.
]

{ #category : #accessing }
SteloCode class >> clearUsedCommands [
	"self clearUsedCommands"
	UsedCommands := Set new.
]

{ #category : #'class initialization' }
SteloCode class >> initialize [
	self clearUsedCommands.
]

{ #category : #accessing }
SteloCode class >> usedCommands [
	^ UsedCommands
]

{ #category : #'sensing ops' }
SteloCode >> aimHigh: var [
	^ bcGenerator aimHighVar: (targetMorph patchVarId varNoFor: var choice)
]

{ #category : #'list ops' }
SteloCode >> append: anObject toList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		append: [ anObject argString: parser ]
		toList: (targetMorph varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> changePatchVar: var at: pno by: num [
	bcGenerator
		changePatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		by: [ num argString: parser ].
]

{ #category : #'variable ops' }
SteloCode >> changeVar: var by: num [
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		changeVar: [ targetMorph varId varNoFor: v ]
		by: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> changeXposBy: num [
	bcGenerator changeXposBy: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> changeYposBy: num [
	bcGenerator changeYposBy: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> clearAll [
	bcGenerator clearAll.
]

{ #category : #'basic ops' }
SteloCode >> clearGraphics [
	bcGenerator clearGraphics.
]

{ #category : #'list ops' }
SteloCode >> clearList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator clearList: (targetMorph varId varNoFor: v)
]

{ #category : #'pen ops' }
SteloCode >> clearPlots [
	bcGenerator clearPlots
]

{ #category : #'basic ops' }
SteloCode >> clearTurtle: bno [
	bcGenerator clearTurtle: [ bno argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> clearTurtles [
	bcGenerator clearTurtles.
]

{ #category : #'color ops' }
SteloCode >> colorBlack [
	^ self colorOf: #black
]

{ #category : #'color ops' }
SteloCode >> colorBlue [
	^ self colorOf: #blue
]

{ #category : #'color ops' }
SteloCode >> colorBrown [
	^ self colorOf: #brown
]

{ #category : #'color ops' }
SteloCode >> colorCyan [
	^ self colorOf: #cyan
]

{ #category : #'color ops' }
SteloCode >> colorGray [
	^ self colorOf: #gray
]

{ #category : #'color ops' }
SteloCode >> colorGreen [
	^ self colorOf: #green
]

{ #category : #'color ops' }
SteloCode >> colorLime [
	^ self colorOf: #lime
]

{ #category : #'color ops' }
SteloCode >> colorMagenta [
	^ self colorOf: #magenta
]

{ #category : #private }
SteloCode >> colorOf: aSymbol [
	^ SColorList colorOf: aSymbol
]

{ #category : #'color ops' }
SteloCode >> colorOrange [
	^ self colorOf: #orange
]

{ #category : #'color ops' }
SteloCode >> colorPink [
	^ self colorOf: #pink
]

{ #category : #'color ops' }
SteloCode >> colorPurple [
	^ self colorOf: #purple
]

{ #category : #'color ops' }
SteloCode >> colorRandom [
	^ bcGenerator randomFrom: 1 to: SColorList default size - 1
]

{ #category : #'color ops' }
SteloCode >> colorRed [
	^ self colorOf: #red
]

{ #category : #'color ops' }
SteloCode >> colorSky [
	^ self colorOf: #sky
]

{ #category : #'color ops' }
SteloCode >> colorTurquoise [
	^ self colorOf: #turquoise
]

{ #category : #'color ops' }
SteloCode >> colorWhite [
	^ self colorOf: #white
]

{ #category : #'color ops' }
SteloCode >> colorYellow [
	^ self colorOf: #yellow
]

{ #category : #'basic ops' }
SteloCode >> createPatchesSize: size [
	bcGenerator createPatchesSize: [ size argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> createTurtleSize: size breedId: bno [
	bcGenerator
		createTurtleSize: [ size argString: parser ]
		breedId: [ bno argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> deleteLine: anInteger ofList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		deleteLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> diffuse4Var: var percentage: num [
	bcGenerator
		diffuse4Var: (targetMorph patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
]

{ #category : #'patch ops' }
SteloCode >> diffuseVar: var percentage: num [
	bcGenerator
		diffuseVar: (targetMorph patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> directionTo: pno [
	^ bcGenerator directionTo: (pno argString: parser)
]

{ #category : #'sensing ops' }
SteloCode >> distanceTo: pno [
	^ bcGenerator distanceTo: (pno argString: parser)
]

{ #category : #'sensing ops' }
SteloCode >> dx [
	^ bcGenerator dx
]

{ #category : #'sensing ops' }
SteloCode >> dy [
	^ bcGenerator dy
]

{ #category : #'basic ops' }
SteloCode >> forward: num [
	bcGenerator forward: [ num argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> front [
	^ bcGenerator front
]

{ #category : #'color ops' }
SteloCode >> getColor [
	^ bcGenerator getColor
]

{ #category : #'sensing ops' }
SteloCode >> getHeading [
	^ bcGenerator getVar: STurtleVarDef headingVarNo
]

{ #category : #'list ops' }
SteloCode >> getLine: anInteger ofList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator
		getLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> getObserverVar: var [
	^ bcGenerator
		getObserverVar: (targetMorph observerVarId varNoFor: var choice)
]

{ #category : #'patch ops' }
SteloCode >> getPatchColorAt: pno [
	^ bcGenerator getPatchColorAt: (pno argString: parser)
]

{ #category : #'patch ops' }
SteloCode >> getPatchVar: var at: pno [
	^ bcGenerator
		getPatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> getTurtle: tno breed: bno var: var [
	^ bcGenerator
		getVar: [ :b | targetMorph varFor: var choice breed: b ]
		breedNo: [ bno argString: parser ]
		index: [ tno argString: parser ]
]

{ #category : #'variable ops' }
SteloCode >> getVar: var [
	| v |
	v := var variable.
	^ bcGenerator getVar: (targetMorph varId varNoFor: v)
]

{ #category : #'sensing ops' }
SteloCode >> getXpos [
	^ bcGenerator getXpos
]

{ #category : #'sensing ops' }
SteloCode >> getYpos [
	^ bcGenerator getYpos
]

{ #category : #'basic ops' }
SteloCode >> hatch [
	bcGenerator hatch.
]

{ #category : #'sensing ops' }
SteloCode >> here [
	^ bcGenerator here
]

{ #category : #initialization }
SteloCode >> initialize [
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
	bcGenerator := SteloBytecodeGenerator new.
]

{ #category : #'pen ops' }
SteloCode >> isPenDown [
	^ bcGenerator isPenDown
]

{ #category : #'sensing ops' }
SteloCode >> kill: tno breed: bno [
	bcGenerator
		kill: [ tno argString: parser ]
		breed: [ bno argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> lineCountOfList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator lineCountOfList: (targetMorph varId varNoFor: v)
]

{ #category : #'list ops' }
SteloCode >> list: aList contains: anInteger [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ bcGenerator
		list: (targetMorph varId varNoFor: v)
		contains: [ anInteger argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> multiplyVar: var by: num [
	bcGenerator
		multiplyVar: (targetMorph patchVarId varNoFor: var choice)
		by: [ num argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> nsum4Var: var1 to: var2 [
	bcGenerator
		nsum4Var: (targetMorph patchVarId varNoFor: var1 choice)
		to: (targetMorph patchVarId varNoFor: var2 choice).
]

{ #category : #'patch ops' }
SteloCode >> nsumVar: var1 to: var2 [
	bcGenerator
		nsumVar: (targetMorph patchVarId varNoFor: var1 choice)
		to: (targetMorph patchVarId varNoFor: var2 choice).
]

{ #category : #'sensing ops' }
SteloCode >> patchAtX: x y: y [
	^ bcGenerator
		patchAtX: [ x argString: parser ]
		y: [ y argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> penDown [
	bcGenerator penDown: true.
]

{ #category : #'pen ops' }
SteloCode >> penUp [
	bcGenerator penDown: false.
]

{ #category : #'pen ops' }
SteloCode >> plot: anInteger color: color [
	bcGenerator
		plot: [ anInteger argString: parser ]
		color: [ color argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> plot: anInteger data: aFloat [
	bcGenerator
		plot: [ anInteger argString: parser ]
		data: [ aFloat argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> relativeToR: r theta: theta [
	^ bcGenerator
		relativeToR: [ r argString: parser ]
		theta: [ theta argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> relativeToX: x y: y [
	^ bcGenerator
		relativeToX: [ x argString: parser ]
		y: [ y argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> scalePatch: var color: color from: from to: to [
	bcGenerator
		scaleValue: (targetMorph patchVarId varNoFor: var choice)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
]

{ #category : #'color ops' }
SteloCode >> scaleValue: var color: color from: from to: to [
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ ^ self ].
	bcGenerator
		scaleValue: (targetMorph varId varNoFor: v)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> screenHeight [
	^ bcGenerator getObserverVar: SObserverVarDef heightVarNo
]

{ #category : #'sensing ops' }
SteloCode >> screenWidth [
	^ bcGenerator getObserverVar: SObserverVarDef widthVarNo
]

{ #category : #'color ops' }
SteloCode >> setColor: color [
	bcGenerator setColorTo: [ color argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setHeading: angle [
	bcGenerator setHeading: [ angle argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> setLine: anInteger ofList: aList to: anObject [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		setLine: [ anInteger argString: parser ]
		ofList: (targetMorph varId varNoFor: v)
		to: [ anObject argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> setPatchColorAt: pos to: color [
	bcGenerator
		setPatchColorAt: [ pos argString: parser ]
		to: [ color argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> setPatchVar: var at: pno to: num [
	bcGenerator
		setPatchVar: (targetMorph patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		to: [ num argString: parser ].
]

{ #category : #'pen ops' }
SteloCode >> setPlotYMax: aNumber [
	bcGenerator setPlotYMax: [ aNumber argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> setPlotYMin: aNumber [
	bcGenerator setPlotYMin: [ aNumber argString: parser ]
]

{ #category : #'variable ops' }
SteloCode >> setVar: var to: num [
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	bcGenerator
		setVar: (targetMorph varId varNoFor: v)
		to: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setXpos: num [
	bcGenerator setXpos: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setYpos: num [
	bcGenerator setYpos: [ num argString: parser ].
]

{ #category : #'pen ops' }
SteloCode >> stamp [
	bcGenerator stamp.
]

{ #category : #'sensing ops' }
SteloCode >> ticks [
	^ bcGenerator getObserverVar: SObserverVarDef ticksVarNo
]

{ #category : #'basic ops' }
SteloCode >> turn: angle [
	bcGenerator turn: [ angle argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> turtle: bno at: pno [
	^ bcGenerator
		turtle: [ bno argString: parser ]
		at: [ pno argString: parser ]
]

{ #category : #'basic ops' }
SteloCode >> turtlesCount: bno [
	^ bcGenerator
		getObserverVar: SObserverVarDef countAliveVarNo
		arg: (bno argString: parser)
]
