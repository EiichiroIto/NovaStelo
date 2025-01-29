Class {
	#name : 'ObserverScript',
	#superclass : 'SteloScript',
	#category : 'Stelo-Project',
	#package : 'Stelo',
	#tag : 'Project'
}

{ #category : 'block specs' }
ObserverScript >> addBasicBlocks [

	blockMorphBuilder
		addCategory: 'basic';
		addCommand: 'set patch size to %n' selector: #createPatchesSize: arguments: #( 100 );
		addCommand: 'create %n %m' selector: #createTurtleSize:breedId: arguments: #( 100 '' );
		addSeparator;
		addCommand: 'clear all' selector: #clearAll;
		addCommand: 'clear graphics' selector: #clearGraphics;
		addCommand: 'clear turtles' selector: #clearTurtles;
		addCommand: 'clear turtle %m' selector: #clearTurtle: arguments: #( '' ).
	super addBasicBlocks.
	blockMorphBuilder
		addSeparator;
		addCommand: 'set random seed %n' selector: #setRandomSeed: arguments: #( 0 )
]

{ #category : 'block specs' }
ObserverScript >> addBlockSpecs [

	super addBlockSpecs.
	self
		addPatchBlocks;
		addPenBlocks;
		addListBlocks
]

{ #category : 'block specs' }
ObserverScript >> addControlBlocks [

	blockMorphBuilder
		addCategory: 'control';
		addStartHatBlock: 'when setup' selector: #startup.
	super addControlBlocks
]

{ #category : 'block specs' }
ObserverScript >> addPatchBlocks [

	blockMorphBuilder
		addCategory: 'patch';
		addCommand: 'set patch''s %p to %p' selector: #copyPatchVar:to: arguments: #( '' '' );
		addCommand: 'change patch''s %p by %n' selector: #changePatchVar:by: arguments: #( '' 0.1 );
		addCommand: 'multiply patch''s %p by %n' selector: #multiplyVar:by: arguments: #( '' 0.9 );
		addCommand: 'scale patch''s %p color %c from %n to %n' selector: #scalePatch:color:from:to: arguments: #( '' 15 1 100 );
		addSeparator;
		addCommand: 'diffuse patch''s %p %n' selector: #diffuseVar:percentage: arguments: #( '' 20 );
		addCommand: 'diffuse4 patch''s %p %n' selector: #diffuse4Var:percentage: arguments: #( '' 20 );
		addCommand: 'nsum patch''s %p to %p' selector: #nsumVar:to: arguments: #( '' '' );
		addCommand: 'nsum4 patch''s %p to %p' selector: #nsum4Var:to: arguments: #( '' '' )
]

{ #category : 'block specs' }
ObserverScript >> addPenBlocks [

	blockMorphBuilder
		addCategory: 'pen';
		addCommand: 'clear plots' selector: #clearPlots;
		addCommand: 'set plot %n color %c' selector: #plot:color: arguments: #( 1 15 );
		addCommand: 'set y min to %n' selector: #setPlotYMin: arguments: #( 0 );
		addCommand: 'set y max to %n' selector: #setPlotYMax: arguments: #( 100 );
		addSeparator;
		addCommand: 'plot %n data %n' selector: #plot:data: arguments: #( 1 10 )
]

{ #category : 'testing' }
ObserverScript >> isObserver [
	^ true
]

{ #category : 'accessing' }
ObserverScript >> objName [
	^ 'Observer'
]

{ #category : 'testing' }
ObserverScript >> useList [
	^ true
]
