Class {
	#name : 'PatchesScript',
	#superclass : 'SteloScript',
	#category : 'Stelo-Project',
	#package : 'Stelo',
	#tag : 'Project'
}

{ #category : 'block specs' }
PatchesScript >> addBlockSpecs [

	self
		addColorBlocks;
		addConstantColorBlocks;
		addObserverBlocks;
		addListBlocks.
	super addBlockSpecs
]

{ #category : 'block specs' }
PatchesScript >> addSensingBlocks [

	blockMorphBuilder
		addCategory: 'sensing';
		addReporter: 'id' selector: #getId;
		addReporter: 'x position' selector: #getXpos;
		addReporter: 'y position' selector: #getYpos;
		addReporter: 'one of %m at %n' selector: #turtle:at: arguments: #( '' 0 );
		addReporter: 'distance to %n' selector: #distanceTo: arguments: #( 0 );
		addReporter: 'direction to %n' selector: #directionTo: arguments: #( 0 );
		addSeparator;
		addReporter: 'here' selector: #here;
		addReporter: 'x %n y %n from here' selector: #relativeToX:y: arguments: #( 0 0 );
		addReporter: 'r %n theta %n from here' selector: #relativeToR:theta: arguments: #( 0 0 ).
	super addSensingBlocks
]

{ #category : 'testing' }
PatchesScript >> isPatches [
	^ true
]

{ #category : 'accessing' }
PatchesScript >> objName [
	^ 'Patches'
]
