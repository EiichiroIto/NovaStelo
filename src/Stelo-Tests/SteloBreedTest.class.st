"
A SBreedTest is a test class for testing the behavior of SBreed
"
Class {
	#name : #SteloBreedTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloBreedTest >> newObj [

	^ SteloBreed new
]

{ #category : #test }
SteloBreedTest >> testAddList [
	| br a b |
	br := SteloBreed new.
	a := br addList: 'a'.
	b := br addList: 'b'.
	self assert: a ~= b.
	self assert: (br variables privVarNames includes: 'a' ).
	self assert: (br variables privVarNames includes: 'b' ).
	self assert: (br varDef listNames includes: 'a' ).
	self assert: (br varDef listNames includes: 'b' ).
]

{ #category : #test }
SteloBreedTest >> testAddVariable [
	| br a b |
	br := SteloBreed new.
	a := br addVariable: 'a'.
	b := br addVariable: 'b'.
	self assert: a ~= b.
	self assert: (br variables privVarNames includes: 'a' ).
	self assert: (br variables privVarNames includes: 'b' ).
]

{ #category : #test }
SteloBreedTest >> testColorAt [
	| ps |
	ps := SPatches new.
	ps create: 3.
	(ps variables varAt: 1) setArray: #[0 1 0 2 0 3 0 0 0].
	self assert: (ps colorAt: 1) equals: 0.
	self assert: (ps colorAt: 2) equals: 1.
	self assert: (ps colorAt: 3) equals: 0.
	self assert: (ps colorAt: 4) equals: 2.
]

{ #category : #test }
SteloBreedTest >> testColorAtPut [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assertCollection: ps colors equals: #[0 0 0 0 0 0 0 0 0].
	ps colorAt: 1 put: 1.
	ps colorAt: 2 put: 30.
	ps colorAt: 9 put: 41.
	self assertCollection: ps colors equals: #[1 30 0 0 0 0 0 0 41]
]

{ #category : #test }
SteloBreedTest >> testColors [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assert: ps colors size equals: 9.
	self assert: (ps colors allSatisfy: [ :each | each = 0 ]).
]

{ #category : #test }
SteloBreedTest >> testCountAlive [
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps countAlive equals: 25.
	ps create: 10.
	self assert: ps countAlive equals: 100.
]

{ #category : #test }
SteloBreedTest >> testDeleteVariable [
	| br a b |
	br := SteloBreed new.
	a := br addVariable: 'a'.
	b := br addVariable: 'b'.
	self assert: a ~= b.
	br deleteVariable: 'b'.
	self assert: (br variables privVarNames includes: 'a' ).
	self deny: (br variables privVarNames includes: 'b' ).
	self assert: (br varDef privVarNames includes: 'a' ).
	self deny: (br varDef privVarNames includes: 'b' ).
]

{ #category : #test }
SteloBreedTest >> testInitialize [
	| br |
	br := SteloBreed new.
	self assert: br varDef class equals: VarDef.
	self assert: br variables class equals: Variables.
]

{ #category : #test }
SteloBreedTest >> testRealVarNames [

	| obj |
	obj := self newObj.
	self assert: obj realVarNames isEmpty.
	obj varDef addVariable: 'abc'.
	obj varDef addReservedVariable: 'def' varNo: 1.
	obj varDef addVariable: 'ghi'.
	self assertCollection: obj realVarNames equals: #( 'abc' 'ghi' )
]

{ #category : #test }
SteloBreedTest >> testReset [

	| obj |
	obj := self newObj.
	obj addVariable: 'abc'.
	self assert: obj varDef size equals: 1.
	obj reset.
	self assert: obj varDef size equals: 0
]

{ #category : #test }
SteloBreedTest >> testScaleVarNoColorFromToIndex [
	| br a |
	br := STurtles new.
	a := br addVariable: 'a'.
	br variables forceSize: 2.
	br var: a at: 1 put: 0.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: ColorList black.
	br var: a at: 1 put: 10.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: ColorList white.
	br var: a at: 1 put: 5.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 34.
	br var: a at: 1 put: 1.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 30.
	br var: a at: 1 put: 9.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 39.
	br var: a at: 1 put: 10.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: ColorList black.
	br var: a at: 1 put: 0.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: ColorList white.
	br var: a at: 1 put: 5.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 34.
	br var: a at: 1 put: 1.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 39.
	br var: a at: 1 put: 9.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 30
]

{ #category : #test }
SteloBreedTest >> testUserDefinedListNames [

	| obj |
	obj := self newObj.
	self assert: obj userDefinedListNames isEmpty.
	obj varDef addList: 'abc'.
	obj varDef addVariable: 'def'.
	obj varDef addList: 'ghi'.
	self assertCollection: obj userDefinedListNames equals: #( 'abc' 'ghi' )
]

{ #category : #test }
SteloBreedTest >> testUserDefinedVarNames [
	| ts ps l |
	ts := STurtles new.
	ts addVariable: 'a'.
	l := ts userDefinedVarNames.
	self assertCollection: l asArray equals: #('a').
	ts addVariable: 'b'.
	l := ts userDefinedVarNames.
	self assertCollection: l asArray equals: #('a' 'b').
	ps := SPatches new.
	ps addVariable: 'a'.
	l := ps userDefinedVarNames.
	self assertCollection: l asArray equals: #('a').
	ps addVariable: 'b'.
	l := ps userDefinedVarNames.
	self assertCollection: l asArray equals: #('a' 'b').
]

{ #category : #test }
SteloBreedTest >> testUserDefinedVarNoAndNames [
	| ts ps l |
	ts := STurtles new.
	ts addVariable: 'a'.
	l := ts userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((6 'a')).
	ts addVariable: 'b'.
	l := ts userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((6 'a') (7 'b')).
	ps := SPatches new.
	ps addVariable: 'a'.
	l := ps userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((5 'a')).
	ps addVariable: 'b'.
	l := ps userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((5 'a') (6 'b')).
]

{ #category : #test }
SteloBreedTest >> testVarAt [
	| br a |
	br := SteloBreed new.
	a := br addVariable: 'a'.
	br variables forceSize: 2.
	br var: a at: 1 put: 1.
	br var: a at: 2 put: 3.
	self assert: ((br variables privVars at: a) at: 1) equals: 1.
	self assert: ((br variables privVars at: a) at: 2) equals: 3.
	self assert: (br var: a at: 1) equals: 1.
	self assert: (br var: a at: 2) equals: 3.
	br var: a at: 1 put: 5.
	br var: a at: 2 put: 2.
	self assert: ((br variables privVars at: a) at: 1) equals: 5.
	self assert: ((br variables privVars at: a) at: 2) equals: 2.
	self assert: (br var: a at: 1) equals: 5.
	self assert: (br var: a at: 2) equals: 2
]

{ #category : #test }
SteloBreedTest >> testVarAtPut [
	| br a |
	br := SteloBreed new.
	a := br addVariable: 'a'.
	br variables forceSize: 2.
	self assert: ((br variables privVars at: a) at: 1) equals: 0.
	self assert: ((br variables privVars at: a) at: 2) equals: 0.
	br var: a at: 1 put: 1.
	br var: a at: 2 put: 3.
	self assert: ((br variables privVars at: a) at: 1) equals: 1.
	self assert: ((br variables privVars at: a) at: 2) equals: 3.
	br var: a at: 1 put: 5.
	br var: a at: 2 put: 2.
	self assert: ((br variables privVars at: a) at: 1) equals: 5.
	self assert: ((br variables privVars at: a) at: 2) equals: 2
]

{ #category : #test }
SteloBreedTest >> testVarDef [

	| obj x |
	obj := self newObj.
	self assert: (obj varDef isKindOf: VarDef).
	x := VarDef new.
	obj varDef: x.
	self assert: obj varDef identicalTo: x
]

{ #category : #test }
SteloBreedTest >> testVarFor [
	| s |
	s := STurtles new.
	self assert: (s varNoFor: 'color') equals: STurtlesVarDef colorVarNo.
	self assert: (s varNoFor: 'x') equals: STurtlesVarDef xVarNo.
	self assert: (s varNoFor: 'y') equals: STurtlesVarDef yVarNo.
]

{ #category : #test }
SteloBreedTest >> testVarId [
	| obj |
	obj := STurtles new.
	self assert: obj varDef class equals: STurtlesVarDef.
	obj := SPatches new.
	self assert: obj varDef class equals: SPatchesVarDef
]

{ #category : #test }
SteloBreedTest >> testVarNames [
	| ts ps l |
	ts := STurtles new.
	ts addVariable: 'a'.
	l := ts varNames.
	self assertCollection: l equals: #('color' 'flag' 'x' 'y' 'heading' 'a').
	ts addVariable: 'b'.
	l := ts varNames.
	self assertCollection: l equals: #('color' 'flag' 'x' 'y' 'heading' 'a' 'b').
	ps := SPatches new.
	ps addVariable: 'a'.
	l := ps varNames.
	self assertCollection: l equals: #('color' 'screen' 'x' 'y' 'a').
	ps addVariable: 'b'.
	l := ps varNames.
	self assertCollection: l equals: #('color' 'screen' 'x' 'y' 'a' 'b').
]

{ #category : #test }
SteloBreedTest >> testVarNoFor [

	| obj |
	obj := self newObj.
	self should: [ obj varNoFor: 'abc' ] raise: Error.
	obj varDef addList: 'abc'.
	obj varDef addVariable: 'def'.
	obj varDef addList: 'ghi'.
	self assert: (obj varNoFor: 'abc') equals: 1.
	self assert: (obj varNoFor: 'def') equals: 2.
	self assert: (obj varNoFor: 'ghi') equals: 3
]

{ #category : #test }
SteloBreedTest >> testVariableNameInUse [
	| br |
	br := SteloBreed new.
	self deny: (br variableNameInUse: 'a').
	br addVariable: 'a'.
	self assert: (br variableNameInUse: 'a').
	br deleteVariable: 'a'.
	self deny: (br variableNameInUse: 'a').
]

{ #category : #test }
SteloBreedTest >> testVariables [

	| obj v |
	obj := STurtles new.
	self assert: (obj variables isKindOf: Variables).
	obj := SPatches new.
	self assert: (obj variables isKindOf: Variables).
	v := Variables new.
	obj variables: v.
	self assert: obj variables identicalTo: v
]
