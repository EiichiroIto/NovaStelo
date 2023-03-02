Class {
	#name : #SPatchesVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
SPatchesVarDefTest >> testClassNameFor [
	| pv |
	pv := SPatchesVarDef new.
	self assert: (pv classNameFor: 'color') equals: #ByteArray.
	self assert: (pv classNameFor: 'screen') equals: #ByteArray.
	self assert: (pv classNameFor: 'x') equals: #FloatArray.
	self assert: (pv classNameFor: 'y') equals: #FloatArray
]

{ #category : #'tests-accessing' }
SPatchesVarDefTest >> testColorVarNo [

	| v |
	v := SPatchesVarDef new.
	self assert: (v varNoFor: 'color') equals: SPatchesVarDef colorVarNo.
	self assert: SPatchesVarDef colorVarNo equals: 1
]

{ #category : #'tests-initialization' }
SPatchesVarDefTest >> testInitialize [
	| v |
	v := SPatchesVarDef new.
	self assert: v privVarNames size equals: 4.
	self assert: (v includes: 'color').
	self assert: (v includes: 'screen').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').
]

{ #category : #'tests-private' }
SPatchesVarDefTest >> testReservedVarNames [
	self assertCollection: SPatchesVarDef new privReservedVarNames equals: #(color screen x y).
]

{ #category : #'tests-accessing' }
SPatchesVarDefTest >> testScreenVarNo [
	| v |
	v := SPatchesVarDef new.
	self assert: (v varNoFor: 'screen') equals: SPatchesVarDef screenVarNo.
]

{ #category : #'tests-accessing' }
SPatchesVarDefTest >> testXVarNo [
	| v |
	v := SPatchesVarDef new.
	self assert: (v varNoFor: 'x') equals: SPatchesVarDef xVarNo.
]

{ #category : #'tests-accessing' }
SPatchesVarDefTest >> testYVarNo [
	| v |
	v := SPatchesVarDef new.
	self assert: (v varNoFor: 'y') equals: SPatchesVarDef yVarNo.
]
