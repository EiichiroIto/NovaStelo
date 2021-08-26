Class {
	#name : #TurtlesScript,
	#superclass : #SteloScript,
	#instVars : [
		'objName'
	],
	#category : #'Stelo-Project'
}

{ #category : #'block specs' }
TurtlesScript >> blocks [
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
		'basic'
			('forward %n'		- forward: 1)
			('turn %n'				- turn: 5)
			('heading %n'		- setHeading: 0)
			-
			('change x by %n'		-	changeXposBy: 1)
			('set x to %n'				-	setXpos: 0)
			('change y by %n'		-	changeYposBy: 1)
			('set y to %n'				-	setYpos: 0)
			-
			('hatch'					-	hatch)
			('die'						- die)
		'pen'
			('stamp'				- stamp)
			('pen up'				- penUp)
			('pen down'			- penDown)
			('is pen down?'	r isPenDown)
		'sensing'
			('id'					r	getId)
			('x position'		r	getXpos)
			('y position'		r	getYpos)
			('heading'			r	getHeading)
			('dx'					r	dx)
			('dy'					r	dy)
			('breed id'			r	getBreedId)
			-
			('one of %m at %n'				r	turtle:at: '' 'where')
			('distance to %n'				r	distanceTo: 'where')
			('direction to %n'				r	directionTo: 'where')
			('aim high %p'			r	aimHigh: '')
			-
			('%n of %m ''s %t'	r	getTurtle:breed:var:		0 '' '')
			-
			('here'								r	here)
			('front'							r	front)
			('x %n y %n from here'	r	relativeToX:y:		0 0)
			('r %n theta %n from here'	r	relativeToR:theta:		0 0)
		'control'
			('when setup'		S	-)
		'patch'
			('patch color at %n' 			r 	getPatchColorAt: 'where')
			('set patch color at %n to %c'			- setPatchColorAt:to: 'where' 15)
			-
			('patch''s %p at %n'							r 	getPatchVar:at: 	'' 'where')
			('set patch''s %p at %n to %n'			-	setPatchVar:at:to: '' 'where' 0)
			('change patch''s %p at %n by %n'		-	changePatchVar:at:by: '' 'where' 1)
			-
			('change observer''s %o by %n'				-	changeObserverVar:by: '' 1)
	).

	^ blocks, self colorBlocks, self variablesBlocks, super blocks, self observerBlocks
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
