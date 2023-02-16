Class {
	#name : #TurtlesScript,
	#superclass : #SteloScript,
	#instVars : [
		'objName'
	],
	#category : #'Stelo-Project'
}

{ #category : #'block specs' }
TurtlesScript >> addBasicBlocks [

	blockMorphBuilder
		addCategory: 'basic';
		addCommand: 'forward %n' selector: #forward: arguments: #( 1 );
		addCommand: 'turn %n' selector: #turn: arguments: #( 5 );
		addCommand: 'heading %n' selector: #setHeading: arguments: #( 0 );
		addSeparator;
		addCommand: 'change x by %n' selector: #changeXposBy: arguments: #( 1 );
		addCommand: 'set x to %n' selector: #setXpos: arguments: #( 0 );
		addCommand: 'change y by %n' selector: #changeYposBy: arguments: #( 1 );
		addCommand: 'set y to %n' selector: #setYpos: arguments: #( 0 );
		addSeparator;
		addCommand: 'hatch' selector: #hatch;
		addCommand: 'die' selector: #die.
	super addBasicBlocks
]

{ #category : #'block specs' }
TurtlesScript >> addBlockSpecs [

	self
		addPatchBlocks;
		addPenBlocks;
		addColorBlocks;
		addConstantColorBlocks;
		addObserverBlocks;
		addListBlocks.
	super addBlockSpecs
]

{ #category : #'block specs' }
TurtlesScript >> addPatchBlocks [

	blockMorphBuilder
		addCategory: 'patch';
		addReporter: 'patch''s %p at %n' selector: #getPatchVar:at: arguments: #( '' 0 );
		addCommand: 'set patch''s %p at %n to %n' selector: #setPatchVar:at:to: arguments: #( '' 0 0 );
		addCommand: 'change patch''s %p at %n by %n' selector: #changePatchVar:at:by: arguments: #( '' 0 1 )
]

{ #category : #'block specs' }
TurtlesScript >> addPenBlocks [

	blockMorphBuilder
		addCategory: 'pen';
		addCommand: 'stamp' selector: #stamp;
		addCommand: 'pen up' selector: #penUp;
		addCommand: 'pen down' selector: #penDown;
		addReporter: 'is pen down?' selector: #isPenDown
]

{ #category : #'block specs' }
TurtlesScript >> addSensingBlocks [

	blockMorphBuilder
		addCategory: 'sensing';
		addReporter: 'id' selector: #getId;
		addReporter: 'x position' selector: #getXpos;
		addReporter: 'y position' selector: #getYpos;
		addReporter: 'heading' selector: #getHeading;
		addReporter: 'dx' selector: #dx;
		addReporter: 'dy' selector: #dy;
		addReporter: 'breed id' selector: #getBreedId;
		addSeparator;
		addReporter: 'one of %m at %n' selector: #turtle:at: arguments: #( '' 0 );
		addReporter: 'distance to %n' selector: #distanceTo: arguments: #( 0 );
		addReporter: 'direction to %n' selector: #directionTo: arguments: #( 0 );
		addReporter: 'aim high %p' selector: #aimHigh: arguments: #( '' );
		addSeparator;
		addReporter: '%n of %m ''s %t' selector: #getTurtle:breed:var: arguments: #( 0 '' '' );
		addSeparator;
		addReporter: 'here' selector: #here;
		addReporter: 'front' selector: #front;
		addReporter: 'x %n y %n from here' selector: #relativeToX:y: arguments: #( 0 0 );
		addReporter: 'r %n theta %n from here' selector: #relativeToR:theta: arguments: #( 0 0 ).
	super addSensingBlocks
]

{ #category : #private }
TurtlesScript >> defaultObjName [
	^ 'Turtles', breed breedNo asString
]

{ #category : #'object i/o' }
TurtlesScript >> fieldsVersion [
	^ 1
]

{ #category : #'object i/o' }
TurtlesScript >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(objName) from: anObjStream
]

{ #category : #testing }
TurtlesScript >> isTurtles [
	^ true
]

{ #category : #accessing }
TurtlesScript >> objName [
	^ objName
]

{ #category : #accessing }
TurtlesScript >> objName: aString [
	objName := aString
]

{ #category : #'object i/o' }
TurtlesScript >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(objName) on: anObjStream.
]
