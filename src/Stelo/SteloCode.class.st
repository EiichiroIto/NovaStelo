Class {
	#name : #SteloCode,
	#superclass : #ScratchCode,
	#instVars : [
		'script'
	],
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
	^ generator aimHighVar: (script patchVarId varNoFor: var choice)
]

{ #category : #'list ops' }
SteloCode >> append: anObject toList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		append: [ anObject argString: parser ]
		toList: (script varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> changeObserverVar: var by: num [
	generator
		changeObserverVar: (script observerVarId varNoFor: var choice)
		by: [ num argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> changePatchVar: var at: pno by: num [
	generator
		changePatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		by: [ num argString: parser ].
]

{ #category : #'variable ops' }
SteloCode >> changeVar: var by: num [
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		changeVar: [ script varId varNoFor: v ]
		by: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> changeXposBy: num [
	generator changeXposBy: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> changeYposBy: num [
	generator changeYposBy: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> clearAll [
	generator clearAll.
]

{ #category : #'basic ops' }
SteloCode >> clearGraphics [
	generator clearGraphics.
]

{ #category : #'list ops' }
SteloCode >> clearList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator clearList: (script varId varNoFor: v)
]

{ #category : #'pen ops' }
SteloCode >> clearPlots [
	generator clearPlots
]

{ #category : #'basic ops' }
SteloCode >> clearTurtle: bno [
	generator clearTurtle: [ bno argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> clearTurtles [
	generator clearTurtles.
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
	^ generator randomFrom: 1 to: SColorList default size - 1
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
	generator createPatchesSize: [ size argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> createTurtleSize: size breedId: bno [
	generator
		createTurtleSize: [ size argString: parser ]
		breedId: [ bno argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> deleteLine: anInteger ofList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		deleteLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> diffuse4Var: var percentage: num [
	generator
		diffuse4Var: (script patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
]

{ #category : #'patch ops' }
SteloCode >> diffuseVar: var percentage: num [
	generator
		diffuseVar: (script patchVarId varNoFor: var choice)
		percentage: [ num argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> directionTo: pno [
	^ generator directionTo: (pno argString: parser)
]

{ #category : #'sensing ops' }
SteloCode >> distanceTo: pno [
	^ generator distanceTo: (pno argString: parser)
]

{ #category : #'sensing ops' }
SteloCode >> dx [
	^ generator dx
]

{ #category : #'sensing ops' }
SteloCode >> dy [
	^ generator dy
]

{ #category : #private }
SteloCode >> eventTitleString: aString [
	aString isEmpty ifTrue: [ ^ nil ].
	^ script project eventIdFor: aString asSymbol
]

{ #category : #'basic ops' }
SteloCode >> forward: num [
	generator forward: [ num argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> front [
	^ generator front
]

{ #category : #'code generator' }
SteloCode >> generateSubFooter: aString [
	generator return: 0
]

{ #category : #'color ops' }
SteloCode >> getColor [
	^ generator getColor
]

{ #category : #'sensing ops' }
SteloCode >> getHeading [
	^ generator getVar: STurtleVarDef headingVarNo
]

{ #category : #'list ops' }
SteloCode >> getLine: anInteger ofList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator
		getLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
]

{ #category : #'patch ops' }
SteloCode >> getObserverVar: var [
	^ generator
		getObserverVar: (script observerVarId varNoFor: var choice)
]

{ #category : #'patch ops' }
SteloCode >> getPatchColorAt: pno [
	^ generator getPatchColorAt: (pno argString: parser)
]

{ #category : #'patch ops' }
SteloCode >> getPatchVar: var at: pno [
	^ generator
		getPatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> getTurtle: tno breed: bno var: var [
	^ generator
		getVar: [ :b | script varNoFor: var choice breed: b ]
		breedNo: [ bno argString: parser ]
		index: [ tno argString: parser ]
]

{ #category : #'variable ops' }
SteloCode >> getVar: var [
	| v |
	v := var variable.
	^ generator getVar: (script varId varNoFor: v)
]

{ #category : #'sensing ops' }
SteloCode >> getXpos [
	^ generator getXpos
]

{ #category : #'sensing ops' }
SteloCode >> getYpos [
	^ generator getYpos
]

{ #category : #'basic ops' }
SteloCode >> hatch [
	generator hatch.
]

{ #category : #'sensing ops' }
SteloCode >> here [
	^ generator here
]

{ #category : #'pen ops' }
SteloCode >> isPenDown [
	^ generator isPenDown
]

{ #category : #'sensing ops' }
SteloCode >> kill: tno breed: bno [
	generator
		kill: [ tno argString: parser ]
		breed: [ bno argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> lineCountOfList: aList [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator lineCountOfList: (script varId varNoFor: v)
]

{ #category : #'list ops' }
SteloCode >> list: aList contains: anInteger [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	^ generator
		list: (script varId varNoFor: v)
		contains: [ anInteger argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> multiplyVar: var by: num [
	generator
		multiplyVar: (script patchVarId varNoFor: var choice)
		by: [ num argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> nsum4Var: var1 to: var2 [
	generator
		nsum4Var: (script patchVarId varNoFor: var1 choice)
		to: (script patchVarId varNoFor: var2 choice).
]

{ #category : #'patch ops' }
SteloCode >> nsumVar: var1 to: var2 [
	generator
		nsumVar: (script patchVarId varNoFor: var1 choice)
		to: (script patchVarId varNoFor: var2 choice).
]

{ #category : #accessing }
SteloCode >> parse: aTopBlock target: aScript [
	script := aScript.
	^ self parse: aTopBlock
]

{ #category : #'sensing ops' }
SteloCode >> patchAtX: x y: y [
	^ generator
		patchAtX: [ x argString: parser ]
		y: [ y argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> penDown [
	generator penDown: true.
]

{ #category : #'pen ops' }
SteloCode >> penUp [
	generator penDown: false.
]

{ #category : #'pen ops' }
SteloCode >> plot: anInteger color: color [
	generator
		plot: [ anInteger argString: parser ]
		color: [ color argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> plot: anInteger data: aFloat [
	generator
		plot: [ anInteger argString: parser ]
		data: [ aFloat argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> relativeToR: r theta: theta [
	^ generator
		relativeToR: [ r argString: parser ]
		theta: [ theta argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> relativeToX: x y: y [
	^ generator
		relativeToX: [ x argString: parser ]
		y: [ y argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> scalePatch: var color: color from: from to: to [
	generator
		scaleValue: (script patchVarId varNoFor: var choice)
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
	generator
		scaleValue: (script varId varNoFor: v)
		color: [ color argString: parser ]
		from: [ from argString: parser ]
		to: [ to argString: parser ]
]

{ #category : #'sensing ops' }
SteloCode >> screenHeight [
	^ generator getObserverVar: SObserverVarDef heightVarNo
]

{ #category : #'sensing ops' }
SteloCode >> screenWidth [
	^ generator getObserverVar: SObserverVarDef widthVarNo
]

{ #category : #'color ops' }
SteloCode >> setColor: color [
	generator setColorTo: [ color argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setHeading: angle [
	generator setHeading: [ angle argString: parser ].
]

{ #category : #'list ops' }
SteloCode >> setLine: anInteger ofList: aList to: anObject [
	| v |
	v := aList choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		setLine: [ anInteger argString: parser ]
		ofList: (script varId varNoFor: v)
		to: [ anObject argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> setPatchColorAt: pos to: color [
	generator
		setPatchColorAt: [ pos argString: parser ]
		to: [ color argString: parser ]
]

{ #category : #'patch ops' }
SteloCode >> setPatchVar: var at: pno to: num [
	generator
		setPatchVar: (script patchVarId varNoFor: var choice)
		at: [ pno argString: parser ]
		to: [ num argString: parser ].
]

{ #category : #'pen ops' }
SteloCode >> setPlotYMax: aNumber [
	generator setPlotYMax: [ aNumber argString: parser ]
]

{ #category : #'pen ops' }
SteloCode >> setPlotYMin: aNumber [
	generator setPlotYMin: [ aNumber argString: parser ]
]

{ #category : #'variable ops' }
SteloCode >> setVar: var to: num [
	| v |
	v := var choice.
	v isEmpty
		ifTrue: [ self error ].
	generator
		setVar: (script varId varNoFor: v)
		to: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setXpos: num [
	generator setXpos: [ num argString: parser ].
]

{ #category : #'basic ops' }
SteloCode >> setYpos: num [
	generator setYpos: [ num argString: parser ].
]

{ #category : #'pen ops' }
SteloCode >> stamp [
	generator stamp.
]

{ #category : #'sensing ops' }
SteloCode >> ticks [
	^ generator getObserverVar: SObserverVarDef ticksVarNo
]

{ #category : #'basic ops' }
SteloCode >> turn: angle [
	generator turn: [ angle argString: parser ].
]

{ #category : #'sensing ops' }
SteloCode >> turtle: bno at: pno [
	^ generator
		turtle: [ bno argString: parser ]
		at: [ pno argString: parser ]
]

{ #category : #'basic ops' }
SteloCode >> turtlesCount: bno [
	^ generator
		getObserverVar: SObserverVarDef countAliveVarNo
		arg: (bno argString: parser)
]

{ #category : #private }
SteloCode >> variableArgString: aString [
	| v |
	v := [ script varId varNoFor: aString ] ifError: [ nil ].
	v ifNil: [ ^ 0 ].
	^ generator getVar: v
]
