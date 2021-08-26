Class {
	#name : #SPatchVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testClassNameFor [
	| pv |
	pv := SPatchVarDef new.
	self assert: (pv classNameFor: 'color') equals: #ByteArray.
	self assert: (pv classNameFor: 'screen') equals: #ByteArray.
	self assert: (pv classNameFor: 'x') equals: #FloatArray.
	self assert: (pv classNameFor: 'y') equals: #FloatArray
]

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testColorVarNo [
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'color') equals: SPatchVarDef colorVarNo.
]

{ #category : #'tests-initialization' }
SPatchVarDefTest >> testInitialize [
	| v |
	v := SPatchVarDef new.
	self assert: v privVarNames size equals: 4.
	self assert: (v includes: 'color').
	self assert: (v includes: 'screen').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').
]

{ #category : #'tests-private' }
SPatchVarDefTest >> testReservedVarNames [
	self assertCollection: SPatchVarDef new privReservedVarNames equals: #(color screen x y).
]

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testScreenVarNo [
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'screen') equals: SPatchVarDef screenVarNo.
]

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testXVarNo [
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'x') equals: SPatchVarDef xVarNo.
]

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testYVarNo [
	| v |
	v := SPatchVarDef new.
	self assert: (v varNoFor: 'y') equals: SPatchVarDef yVarNo.
]
