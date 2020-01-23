tests-initialization
testInitialize
	| o |
	o := SObserverVarDef new.
	self assert: o size equals: 7.
	self assert: (o varNoFor: 'width') equals: SObserverVarDef widthVarNo.
	self assert: (o varNoFor: 'height') equals: SObserverVarDef heightVarNo.
	self assert: (o varNoFor: 'maxBreedNo') equals: SObserverVarDef maxBreedNoVarNo.
	self assert: (o varNoFor: 'ticks') equals: SObserverVarDef ticksVarNo.
	self assert: (o varNoFor: 'countAlive') equals: SObserverVarDef countAliveVarNo.
	self assert: (o varNoFor: 'size') equals: SObserverVarDef sizeVarNo.
	self assert: (o varNoFor: 'maxVar') equals: SObserverVarDef maxVarVarNo.