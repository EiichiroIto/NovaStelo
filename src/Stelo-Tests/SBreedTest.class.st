"
A SBreedTest is a test class for testing the behavior of SBreed
"
Class {
	#name : #SBreedTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-variables' }
SBreedTest >> testAddList [
	| br a b |
	br := SBreed new.
	a := br addList: 'a'.
	b := br addList: 'b'.
	self assert: a ~= b.
	self assert: (br privVariables privVarNames includes: 'a' ).
	self assert: (br privVariables privVarNames includes: 'b' ).
	self assert: (br varId listNames includes: 'a' ).
	self assert: (br varId listNames includes: 'b' ).
]

{ #category : #'tests-variables' }
SBreedTest >> testAddVariable [
	| br a b |
	br := SBreed new.
	a := br addVariable: 'a'.
	b := br addVariable: 'b'.
	self assert: a ~= b.
	self assert: (br privVariables privVarNames includes: 'a' ).
	self assert: (br privVariables privVarNames includes: 'b' ).
]

{ #category : #'tests-accessing' }
SBreedTest >> testColorAt [
	| ps |
	ps := SPatches new.
	ps create: 3.
	(ps privVariables varAt: 1) setArray: #[0 1 0 2 0 3 0 0 0].
	self assert: (ps colorAt: 1) equals: 0.
	self assert: (ps colorAt: 2) equals: 1.
	self assert: (ps colorAt: 3) equals: 0.
	self assert: (ps colorAt: 4) equals: 2.
]

{ #category : #'tests-accessing' }
SBreedTest >> testColorAtPut [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assertCollection: ps colors equals: #[0 0 0 0 0 0 0 0 0].
	ps colorAt: 1 put: 1.
	ps colorAt: 2 put: 30.
	ps colorAt: 9 put: 41.
	self assertCollection: ps colors equals: #[1 30 0 0 0 0 0 0 41]
]

{ #category : #'tests-accessing' }
SBreedTest >> testColors [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assert: ps colors size equals: 9.
	self assert: (ps colors allSatisfy: [ :each | each = 0 ]).
]

{ #category : #'tests-accessing' }
SBreedTest >> testCountAlive [
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps countAlive equals: 25.
	ps create: 10.
	self assert: ps countAlive equals: 100.
]

{ #category : #'tests-variables' }
SBreedTest >> testDeleteVariable [
	| br a b |
	br := SBreed new.
	a := br addVariable: 'a'.
	b := br addVariable: 'b'.
	self assert: a ~= b.
	br deleteVariable: 'b'.
	self assert: (br privVariables privVarNames includes: 'a' ).
	self deny: (br privVariables privVarNames includes: 'b' ).
	self assert: (br varId privVarNames includes: 'a' ).
	self deny: (br varId privVarNames includes: 'b' ).
]

{ #category : #'tests-initialization' }
SBreedTest >> testInitialize [
	| br |
	br := SBreed new.
	self assert: br varId class equals: SBreedVarDef.
	self assert: br privVariables class equals: Variables.
]

{ #category : #'tests-private' }
SBreedTest >> testPrivVariables [
	| obj |
	obj := STurtles new.
	self assert: obj privVariables class equals: Variables.
	obj := SPatches new.
	self assert: obj privVariables class equals: Variables
]

{ #category : #'tests-command' }
SBreedTest >> testScaleVarNoColorFromToIndex [
	| br a |
	br := STurtles new.
	a := br addVariable: 'a'.
	br privVariables forceSize: 2.
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

{ #category : #'tests-variables' }
SBreedTest >> testUserDefinedVarNames [
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
SBreedTest >> testUserDefinedVarNoAndNames [
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

{ #category : #'tests-command' }
SBreedTest >> testVarAt [
	| br a |
	br := SBreed new.
	a := br addVariable: 'a'.
	br privVariables forceSize: 2.
	br var: a at: 1 put: 1.
	br var: a at: 2 put: 3.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 1.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 3.
	self assert: (br var: a at: 1) equals: 1.
	self assert: (br var: a at: 2) equals: 3.
	br var: a at: 1 put: 5.
	br var: a at: 2 put: 2.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 5.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 2.
	self assert: (br var: a at: 1) equals: 5.
	self assert: (br var: a at: 2) equals: 2
]

{ #category : #'tests-command' }
SBreedTest >> testVarAtPut [
	| br a |
	br := SBreed new.
	a := br addVariable: 'a'.
	br privVariables forceSize: 2.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 0.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 0.
	br var: a at: 1 put: 1.
	br var: a at: 2 put: 3.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 1.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 3.
	br var: a at: 1 put: 5.
	br var: a at: 2 put: 2.
	self assert: ((br privVariables privVars at: a) at: 1) equals: 5.
	self assert: ((br privVariables privVars at: a) at: 2) equals: 2
]

{ #category : #'tests-accessing' }
SBreedTest >> testVarFor [
	| s |
	s := STurtles new.
	self assert: (s varNoFor: 'color') equals: STurtleVarDef colorVarNo.
	self assert: (s varNoFor: 'x') equals: STurtleVarDef xVarNo.
	self assert: (s varNoFor: 'y') equals: STurtleVarDef yVarNo.
]

{ #category : #'tests-private' }
SBreedTest >> testVarId [
	| obj |
	obj := STurtles new.
	self assert: obj varId class equals: STurtleVarDef.
	obj := SPatches new.
	self assert: obj varId class equals: SPatchVarDef
]

{ #category : #'tests-variables' }
SBreedTest >> testVarNames [
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

{ #category : #'tests-variables' }
SBreedTest >> testVariableNameInUse [
	| br |
	br := SBreed new.
	self deny: (br variableNameInUse: 'a').
	br addVariable: 'a'.
	self assert: (br variableNameInUse: 'a').
	br deleteVariable: 'a'.
	self deny: (br variableNameInUse: 'a').
]
