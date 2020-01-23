Class {
	#name : #SPatchVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
SPatchVarDefTest >> testClassNameForVarNo [
	| pv |
	pv := SPatchVarDef new.
	self assert: (pv classNameForVarNo: SPatchVarDef colorVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: SPatchVarDef screenVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: SPatchVarDef xVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: SPatchVarDef yVarNo) equals: #FloatArray
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
