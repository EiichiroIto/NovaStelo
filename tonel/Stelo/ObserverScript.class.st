Class {
	#name : #ObserverScript,
	#superclass : #SteloScript,
	#instVars : [
		'plotter'
	],
	#category : #'Stelo-Project'
}

{ #category : #'block specs' }
ObserverScript >> blockSpecs [
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
			('set patch size to %n'		- createPatchesSize: 100)
			('create %n %m'			-	createTurtleSize:breedId: 100 '')
			-
			('clear all'				-	clearAll)
			('clear graphics'		-	clearGraphics)
			('clear turtles'			-	clearTurtles)
			('clear turtle %m'		-	clearTurtle: '')
		'patch'
			('scale patch''s %p color %c from %n to %n'  - scalePatch:color:from:to: '' 15 1 100)
			('multiply patch''s %p by %n'	- multiplyVar:by: '' 0.9)
			-
			('diffuse patch''s %p %n'			- diffuseVar:percentage: '' 20)
			('diffuse4 patch''s %p %n'		- diffuse4Var:percentage: '' 20)
			('nsum patch''s %p to %p'			- nsumVar:to: '' '')
			('nsum4 patch''s %p to %p'		- nsum4Var:to: '' '')
		'control'
			('when setup'					T	-)
		'pen'
			('clear plots'								-	clearPlots)
			('set plot %n color %c'				-	plot:color: 1 15)
			('set y min to %n'						-	setPlotYMin: 0)
			('set y max to %n'						-	setPlotYMax: 100)
			-
			('plot %n data %n'						-	plot:data: 1 10)
	).

	^ blocks, super blockSpecs, self variablesBlocks
]

{ #category : #initialization }
ObserverScript >> initialize [
	super initialize.
	plotter := SteloPlotterMorph new
]

{ #category : #testing }
ObserverScript >> isObserver [
	^ true
]

{ #category : #accessing }
ObserverScript >> objName [
	^ 'Observer'
]

{ #category : #accessing }
ObserverScript >> plotter [
	^ plotter
]

{ #category : #accessing }
ObserverScript >> project: aProject [
	super project: aProject.
	plotter project: aProject
]

{ #category : #testing }
ObserverScript >> useList [
	^ true
]
