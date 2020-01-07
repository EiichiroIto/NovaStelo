"
A SVarIdTest is a test class for testing the behavior of SVarId
"
Class {
	#name : #VarDefTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
VarDefTest >> newVarDef [
	^ VarDef new
]

{ #category : #test }
VarDefTest >> testAddClassName [
	| v x |
	v := self newVarDef.
	x := v add: 'a' className: #Array.
	self assert: x equals: 1.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #Array
]

{ #category : #test }
VarDefTest >> testAddComputedVariableVarNo [
	| v a b |
	v := self newVarDef.
	b := v addComputedVariable: 'b' varNo: 1.
	a := v addVariable: 'a'.
	self assert: b equals: 1.
	self assert: a equals: 2.
	self assert: v privVarNames size equals: 2.
	self assert: (v privVarNames includes: 'a').
	self assert: (v privVarNames includes: 'b').
	self assert: v privReservedVarNames size equals: 1.
	self assert: (v privReservedVarNames includes: 'b').
	self assertCollection: v privClassNames size equals: 2.
	self assert: (v privClassNames at: a) equals: #FloatArray.
	self assert: (v privClassNames at: b) equals: nil
]

{ #category : #test }
VarDefTest >> testAddList [
	| v x |
	v := self newVarDef.
	x := v addList: 'a'.
	self assert: x equals: 1.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #Array.
	x := v addList: 'b'.
	self assert: x equals: 2.
	self assert: v privClassNames size equals: 2.
	self assert: (v privClassNames at: x) equals: #Array
]

{ #category : #test }
VarDefTest >> testAddReservedVarNoClassName [
	| v x |
	v := self newVarDef.
	x := v addReserved: 'b' varNo: 2 className: #ByteArray.
	self assert: x equals: 2.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #ByteArray.
	self assert: (v privReservedVarNames includes: 'b')
]

{ #category : #test }
VarDefTest >> testAddReservedVariableVarNo [
	| v a b |
	v := self newVarDef.
	b := v addReservedVariable: 'b' varNo: 1.
	a := v addVariable: 'a'.
	self assert: b equals: 1.
	self assert: a equals: 2.
	self assert: v privVarNames size equals: 2.
	self assert: (v privVarNames includes: 'a').
	self assert: (v privVarNames includes: 'b').
	self assert: v privReservedVarNames size equals: 1.
	self assert: (v privReservedVarNames includes: 'b').
	self assertCollection: v privClassNames size equals: 2.
	self assert: (v privClassNames at: a) equals: #FloatArray.
	self assert: (v privClassNames at: b) equals: #FloatArray.
]

{ #category : #test }
VarDefTest >> testAddVariable [
	| v x |
	v := self newVarDef.
	x := v addVariable: 'a'.
	self assert: x equals: 1.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #FloatArray.
	x := v addVariable: 'b'.
	self assert: x equals: 2.
	self assert: v privClassNames size equals: 2.
	self assert: (v privClassNames at: x) equals: #FloatArray
]

{ #category : #test }
VarDefTest >> testAllVarNames [
	| v ret |
	v := self newVarDef.
	ret := v allVarNames.
	self assert: ret isEmpty.
	v addVariable: 'a'.
	v addList: 'b'.
	ret := v allVarNames.
	self assertCollection: ret equals: #(a b).
]

{ #category : #test }
VarDefTest >> testClassFor [
	| v c |
	v := VarDef new.
	v addVariable: 'a'.
	c := v classFor: 'a'.
	self assert: (c isKindOf: LazyArray).
	self assert: c className equals: #FloatArray
]

{ #category : #test }
VarDefTest >> testClassNameForVarNo [
	| pv a b |
	pv := self newVarDef.
	a := pv add: 'a' className: #Array.
	b := pv add: 'b' className: #ByteArray.
	self assert: (pv classNameForVarNo: a) equals: #Array.
	self assert: (pv classNameForVarNo: b) equals: #ByteArray.
]

{ #category : #test }
VarDefTest >> testDelete [
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assertCollection: v privVarNames asArray equals: #('abc' 'def' 'ghi').
	v delete: 'abc'.
	self assertCollection: v privVarNames asArray equals: #(nil 'def' 'ghi').
]

{ #category : #test }
VarDefTest >> testFixVars [
	| v |
	v := VarDef new.
	v privVarNames: #(a b c b c a) asOrderedCollection.
	self assertCollection: v varNames asArray equals: #(a b c b c a).
	v fixVars.
	self assertCollection: v varNames asArray equals: #(a b c).
]

{ #category : #test }
VarDefTest >> testIncludes [
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assert: (v includes: 'abc').
	self assert: (v includes: 'def').
	self assert: (v includes: 'ghi').
	self assert: (v includes: 'aaa') not.
	self assert: (v includes: 'bbb') not.
]

{ #category : #test }
VarDefTest >> testInitialize [
	| v |
	v := self newVarDef.
	self assert: v varNames isEmpty.
	self assert: v privClassNames isDictionary.
	self assert: v privClassNames isEmpty.
	self assert: v privReservedVarNames isCollection.
	self assert: v privReservedVarNames isEmpty
]

{ #category : #test }
VarDefTest >> testIsReserved [
	| v |
	v := self newVarDef.
	v addReservedVariable: 'b' varNo: 1.
	v addVariable: 'a'.
	self deny: (v isReserved: 'a').
	self assert: (v isReserved: 'b')
]

{ #category : #test }
VarDefTest >> testListNames [
	| v ret |
	v := self newVarDef.
	ret := v listNames.
	self assert: ret isEmpty.
	v addList: 'a'.
	v addList: 'b'.
	ret := v listNames.
	self assertCollection: ret equals: #(a b).
]

{ #category : #test }
VarDefTest >> testPrivClassNames [
	| v |
	v := self newVarDef.
	self assert: v privClassNames isDictionary.
	self assert: v privClassNames isEmpty
]

{ #category : #test }
VarDefTest >> testPrivReservedVarNames [
	| v |
	v := VarDef new.
	self assert: v privReservedVarNames isEmpty.
	v privReservedVarNames: 123.
	self assert: v privReservedVarNames equals: 123
]

{ #category : #test }
VarDefTest >> testPrivVarNames [
	| v |
	v := self newVarDef.
	self assert: v privVarNames isNil.
	v privVarNames: #(1 2 3).
	self assertCollection: v privVarNames equals: #(1 2 3).
]

{ #category : #test }
VarDefTest >> testRealVarNames [
	| v |
	v := VarDef new.
	v addVariable: 'a'.
	v addVariable: 'b'.
	self assertCollection: v realVarNames equals: #(a b).
	v add: 'c' className: nil.
	self assertCollection: v realVarNames equals: #(a b)
]

{ #category : #test }
VarDefTest >> testRegularize [
	| v |
	v := VarDef new.
	v addReservedVariable: 'x' varNo: 1.
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	self assertCollection: v privVarNames asArray equals: #(x a b c).
	v privVarNames: #('a' 'b' 'x' 'c') asOrderedCollection.
	v regularize.
	self assertCollection: v privVarNames asArray equals: #('x' 'a' 'b' 'c')
]

{ #category : #test }
VarDefTest >> testReservedNo [
	| v |
	v := VarDef new.
	self assert: v reservedNo equals: 0
]

{ #category : #test }
VarDefTest >> testSetupVarNames [
	| v |
	v := self newVarDef.
	v addReservedVariable: 'a' varNo: 1.
	v addReservedVariable: 'b' varNo: 2.
	self assert: v varNames isEmpty.
	v setupVarNames.
	self assertCollection: v varNames equals: #('a' 'b').
	v := self newVarDef.
	v addReservedVariable: 'a' varNo: 1.
	v addReservedVariable: 'b' varNo: 3.
	self assert: v varNames isEmpty.
	self should: [ v setupVarNames ] raise: Error
]

{ #category : #test }
VarDefTest >> testSize [
	| v |
	v := self newVarDef.
	v addVariable: 'x'.
	self assert: v size equals: 1.
	v addVariable: 'y'.
	self assert: v size equals: 2.
]

{ #category : #test }
VarDefTest >> testUserDefinedVarNames [
	| v ret |
	v := self newVarDef.
	ret := v userDefinedVarNames.
	self assertCollection: ret equals: #().
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	ret := v userDefinedVarNames.
	self assertCollection: ret equals: #(a b c).
]

{ #category : #test }
VarDefTest >> testUserDefinedVarNoAndNames [
	| v |
	v := self newVarDef .
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	self
		assertCollection: v userDefinedVarNoAndNames asArray
		equals: #(#(1 'a') #(2 'b') #(3 'c')).
]

{ #category : #test }
VarDefTest >> testVarFor [
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assert: (v varNoFor: 'abc') equals: 1.
	self assert: (v varNoFor: 'def') equals: 2.
	self assert: (v varNoFor: 'ghi') equals: 3.
	self should: [v varNoFor: 'aaa'] raise: NotFound.
	self should: [v varNoFor: 'bbb'] raise: NotFound.
]

{ #category : #test }
VarDefTest >> testVarNames [
	| v |
	v := self newVarDef.
	self assert: v varNames isEmpty.
	v addVariable: 'x'.
	v addVariable: 'y'.
	self assertCollection: v varNames equals: #('x' 'y').
]

{ #category : #test }
VarDefTest >> testVarNoFor [
	| v a b c |
	v := VarDef new.
	a := v addVariable: 'a'.
	b := v addVariable: 'b'.
	c := v addVariable: 'c'.
	self assert: a ~= b.
	self assert: b ~= c.
	self assert: c ~= a.
	self assert: (v varNoFor: 'a') equals: a.
	self assert: (v varNoFor: 'b') equals: b.
	self assert: (v varNoFor: 'c') equals: c
]
