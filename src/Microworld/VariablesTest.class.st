"
A SVariablesTest is a test class for testing the behavior of SVariables
"
Class {
	#name : #VariablesTest,
	#superclass : #TestCase,
	#category : #'Microworld-Tests'
}

{ #category : #private }
VariablesTest >> newVarDef [
	^ VarDef new
]

{ #category : #private }
VariablesTest >> newVariables [
	^ Variables new
]

{ #category : #test }
VariablesTest >> testChangeBy [
	| var varId v1 v2 |
	var := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	var updateVarDef: varId.
	var var: v1 at: 1 put: 10.
	var var: v2 at: 1 put: 20.
	self assert: (var var: v1 at: 1) equals: 10.
	self assert: (var var: v2 at: 1) equals: 20.
	var change: v1 by: 2.
	var change: v2 by: 3.
	self assert: (var var: v1 at: 1) equals: 12.
	self assert: (var var: v2 at: 1) equals: 23
]

{ #category : #test }
VariablesTest >> testClear [
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 20.
	v var: v2 at: 2 put: 30.
	self assert: (v privVars at: v1) array notEmpty.
	self assert: (v privVars at: v2) array notEmpty.
	v clear.
	self assert: (v privVars at: v1) array isEmpty.
	self assert: (v privVars at: v2) array isEmpty
]

{ #category : #test }
VariablesTest >> testClearVarNo [
	| v varId v1 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.
	v var: v1 at: 3 put: 3.
	v setVar: v1 toAll: 2.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 2.
	v clearVarNo: v1.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.
]

{ #category : #test }
VariablesTest >> testCopyElementFromTo [
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 20.
	v var: v2 at: 2 put: 30.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 3.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 30.
	v copyElementFrom: 1 to: 2.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 2.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 20.
	v var: v1 at: 1 put: 4.
	self assert: (v var: v1 at: 1) equals: 4.
	self assert: (v var: v1 at: 2) equals: 2.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 20.
]

{ #category : #test }
VariablesTest >> testCopyVarTo [
	| var varId v1 v2 |
	var := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	var updateVarDef: varId.
	var var: v1 at: 1 put: 10.
	var var: v1 at: 2 put: 11.
	var var: v2 at: 1 put: 20.
	var var: v2 at: 2 put: 21.
	self assert: (var var: v1 at: 1) equals: 10.
	self assert: (var var: v1 at: 2) equals: 11.
	self assert: (var var: v2 at: 1) equals: 20.
	self assert: (var var: v2 at: 2) equals: 21.
	var copyVar: v1 to: v2.
	self assert: (var var: v1 at: 1) equals: 10.
	self assert: (var var: v1 at: 2) equals: 11.
	self assert: (var var: v2 at: 1) equals: 10.
	self assert: (var var: v2 at: 2) equals: 11
]

{ #category : #test }
VariablesTest >> testForceSize [
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 20.
	v var: v2 at: 5 put: 30.
	self assert: (v varAt: v1) fixedSize isNil.
	self assert: (v varAt: v2) fixedSize isNil.
	v forceSize: 10.
	self assert: (v varAt: v1) fixedSize equals: 10.
	self assert: (v varAt: v2) fixedSize equals: 10.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 3.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 5) equals: 30.
	self assert: (v var: v1 at: 10) equals: 0.
	self assert: (v var: v2 at: 10) equals: 0.
]

{ #category : #test }
VariablesTest >> testInitialize [
	| v |
	v := self newVariables.
	self assert: v privVarNames isArray.
	self assert: v privVarNames isEmpty.
]

{ #category : #test }
VariablesTest >> testMax [
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 30.
	v var: v2 at: 5 put: 20.
	self assert: v max equals: 100
]

{ #category : #test }
VariablesTest >> testMultiplyBy [
	| var varId v1 v2 |
	var := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	var updateVarDef: varId.
	var var: v1 at: 1 put: 10.
	var var: v2 at: 1 put: 20.
	self assert: (var var: v1 at: 1) equals: 10.
	self assert: (var var: v2 at: 1) equals: 20.
	var multiply: v1 by: 2.
	var multiply: v2 by: 3.
	self assert: (var var: v1 at: 1) equals: 20.
	self assert: (var var: v2 at: 1) equals: 60
]

{ #category : #test }
VariablesTest >> testPrivVarNames [
	| v |
	v := self newVariables.
	self assert: v privVarNames class equals: Array.
	v privVarNames: 123.
	self assert: v privVarNames equals: 123.
	v privVarNames: 234.
	self assert: v privVarNames equals: 234.
]

{ #category : #test }
VariablesTest >> testPrivVars [
	| v |
	v := self newVariables.
	self assert: v privVars isNil.
	v privVars: 123.
	self assert: v privVars equals: 123.
	v privVars: 234.
	self assert: v privVars equals: 234.
]

{ #category : #test }
VariablesTest >> testRealArrayAt [
	| v varId |
	v := self newVariables.
	varId := self newVarDef.
	varId addVariable: 'a'.
	varId addVariable: 'b'.
	v updateVarDef: varId.
	self assert: (v realArrayAt: 1) isEmpty.
	self assert: (v realArrayAt: 2) isEmpty.
	v var: 1 at: 1 put: 10.
	v var: 2 at: 2 put: 20.
	self assertCollection: (v realArrayAt: 1) size equals: 100.
	self assertCollection: (v realArrayAt: 2) size equals: 100.
	self assert: (v realArrayAt: 1) first equals: 10.0.
	self assert: (v realArrayAt: 1) second equals: 0.0.
	self assert: (v realArrayAt: 2) first equals: 0.0.
	self assert: (v realArrayAt: 2) second equals: 20.0.
]

{ #category : #test }
VariablesTest >> testSetVarToAll [
	| v varId v1 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	v var: v1 at: 3 put: 3.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.
	v setVar: v1 toAll: 1.
	self assert: (v var: v1 at: 1) equals: 1.
	self assert: (v var: v1 at: 2) equals: 1.
]

{ #category : #test }
VariablesTest >> testSetVarToArray [
	| v varId v1 a |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	self assert: (v varAt: v1) isEmpty.
	a := #(1 2 3) asFloatArray.
	v setVar: v1 toArray: a.
	self assertCollection: (v realArrayAt: v1) equals: a.
]

{ #category : #test }
VariablesTest >> testSize [
	self testMax
]

{ #category : #test }
VariablesTest >> testStringAt [
	self testStringAtPut
]

{ #category : #test }
VariablesTest >> testStringAtPut [
	| vid var v |
	vid := self newVarDef.
	v := vid add: 'a' className: #StringArray.
	var := self newVariables.
	var updateVarDef: vid.
	self assert: (var string: v at: 1) equals: ''.
	self assert: (var string: v at: 2) equals: ''.
	var string: v at: 1 put: 'abc'.
	var string: v at: 2 put: 'def'.
	self assert: (var string: v at: 1) equals: 'abc'.
	self assert: (var string: v at: 2) equals: 'def'
]

{ #category : #test }
VariablesTest >> testUpdateVarDef [
	| v varId1 varId2 |
	varId1 := self newVarDef.
	varId1 addVariable: 'a'.
	varId1 addVariable: 'b'.
	varId1 addVariable: 'c'.
	v := self newVariables.
	v updateVarDef: varId1.
	self assertCollection: v privVarNames asArray equals: #('a' 'b' 'c').
	self assert: v privVars isArray.
	self assert: v privVars size equals: 3.
	self assert: (v privVars at: 1) isEmpty.
	self assert: (v privVars at: 2) isEmpty.
	self assert: (v privVars at: 3) isEmpty.
	(v privVars at: 1) setArray: #(0 0 0) asFloatArray.
	(v privVars at: 2) setArray: #(1 2 3) asFloatArray.
	(v privVars at: 3) setArray: #(4 5 6) asFloatArray.
	varId2 := self newVarDef.
	varId2 addVariable: 'c'.
	varId2 addVariable: 'b'.
	varId2 addVariable: 'd'.
	v updateVarDef: varId2.
	self assertCollection: v privVarNames asArray equals: #('c' 'b' 'd').
	self assert: v privVars isArray.
	self assert: v privVars size equals: 3.
	self assert: (v privVars at: 1) privArray equals: #(4 5 6) asFloatArray.
	self assert: (v privVars at: 2) privArray equals: #(1 2 3) asFloatArray.
	self assert: (v privVars at: 3) isEmpty.
]

{ #category : #test }
VariablesTest >> testVarAt [
	| vid var v |
	vid := self newVarDef.
	v := vid addVariable: 'a'.
	var := self newVariables.
	var updateVarDef: vid.
	self assert: (var var: v at: 1) equals: 0.
	(var varAt: v) at: 1 put: 1.
	(var varAt: v) at: 2 put: 5.
	self assert: (var var: v at: 1) equals: 1.
	self assert: (var var: v at: 2) equals: 5.
]

{ #category : #test }
VariablesTest >> testVarAt2 [
	| v varId |
	v := self newVariables.
	varId := self newVarDef.
	varId addVariable: 'a'.
	varId addVariable: 'b'.
	v updateVarDef: varId.
	self assert: (v varAt: 1) isEmpty.
	self assert: (v varAt: 2) isEmpty.
	v privVars at: 1 put: 10.
	v privVars at: 2 put: 20.
	self assert: (v varAt: 1) equals: 10.
	self assert: (v varAt: 2) equals: 20.
]

{ #category : #test }
VariablesTest >> testVarAtPut [
	| vid var v |
	vid := self newVarDef.
	v := vid addVariable: 'a'.
	var := self newVariables.
	var updateVarDef: vid.
	self assert: (var var: v at: 1) equals: 0.
	self assert: (var var: v at: 2) equals: 0.
	var var: v at: 1 put: 1.
	var var: v at: 2 put: 5.
	self assert: (var var: v at: 1) equals: 1.
	self assert: (var var: v at: 2) equals: 5.
]

{ #category : #test }
VariablesTest >> testVarList [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	v var: v1 list: 1 add: 40.
	self assertCollection: (v var: v1 list: 1) equals: #(10 20 30 40)
]

{ #category : #test }
VariablesTest >> testVarListAdd [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 add: 10.
	v var: v1 list: 1 add: 20.
	v var: v1 list: 2 add: 5.
	v var: v1 list: 2 add: 6.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 20.
	self assert: (v var: v1 list: 2 at: 1) equals: 5.
	self assert: (v var: v1 list: 2 at: 2) equals: 6
]

{ #category : #test }
VariablesTest >> testVarListAt [
	self testVarListAtPut
]

{ #category : #test }
VariablesTest >> testVarListAtPut [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 at: 1 put: 10.
	v var: v1 list: 1 at: 2 put: 20.
	v var: v1 list: 2 at: 1 put: 5.
	v var: v1 list: 2 at: 2 put: 6.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 20.
	self assert: (v var: v1 list: 2 at: 1) equals: 5.
	self assert: (v var: v1 list: 2 at: 2) equals: 6
]

{ #category : #test }
VariablesTest >> testVarListContains [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 at: 1 put: 10.
	v var: v1 list: 1 at: 2 put: 20.
	v var: v1 list: 2 at: 1 put: 5.
	v var: v1 list: 2 at: 2 put: 6.
	self assert: (v var: v1 list: 1 contains: 10).
	self assert: (v var: v1 list: 1 contains: 20).
	self deny: (v var: v1 list: 1 contains: 30).
	self assert: (v var: v1 list: 2 contains: 5).
	self assert: (v var: v1 list: 2 contains: 6).
	self deny: (v var: v1 list: 2 contains: 7)
]

{ #category : #test }
VariablesTest >> testVarListRemove [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 at: 1 put: 10.
	v var: v1 list: 1 at: 2 put: 20.
	v var: v1 list: 1 at: 3 put: 30.
	v var: v1 list: 1 remove: 2.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 30
]

{ #category : #test }
VariablesTest >> testVarListSet [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	v var: v1 list: 1 add: 40.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 20.
	self assert: (v var: v1 list: 1 at: 3) equals: 30.
	self assert: (v var: v1 list: 1 at: 4) equals: 40
]

{ #category : #test }
VariablesTest >> testVarListSizeOf [
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	self assert: (v var: v1 listSizeOf: 1) equals: 3
]
