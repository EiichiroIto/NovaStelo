microworld
var: anInteger at: id sworld: aWorld
	| v |
	v := varId class.
	anInteger = v widthVarNo
		ifTrue: [ ^ aWorld extent x ].
	anInteger = v heightVarNo
		ifTrue: [ ^ aWorld extent y ].
	anInteger = v maxBreedNoVarNo
		ifTrue: [ ^ aWorld maxBreedNo ].
	anInteger = v ticksVarNo
		ifTrue: [ ^ ticks ].
	anInteger = v countAliveVarNo
		ifTrue: [ ^ aWorld countAliveOf: id ].
	anInteger = v sizeVarNo
		ifTrue: [ ^ aWorld sizeOf: id ].
	anInteger = v maxVarVarNo
		ifTrue: [ ^ varId size ].
	^ self var: anInteger at: id