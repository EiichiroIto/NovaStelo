"
A STurtleVarIdTest is a test class for testing the behavior of STurtleVarId
"
Class {
	#name : #STurtleVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testAliveFlagNo [
	self assert: STurtleVarDef aliveFlagNo equals: 0.
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testClassNameForVarNo [
	| pv |
	pv := STurtleVarDef new.
	self assert: (pv classNameForVarNo: STurtleVarDef colorVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: STurtleVarDef flagVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: STurtleVarDef xVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: STurtleVarDef yVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: STurtleVarDef headingVarNo) equals: #FloatArray
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testColorVarNo [
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'color') equals: STurtleVarDef colorVarNo.
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testFlagVarNo [
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'flag') equals: STurtleVarDef flagVarNo.
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testHeadingVarNo [
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'heading') equals: STurtleVarDef headingVarNo.
]

{ #category : #'tests-initialization' }
STurtleVarDefTest >> testInitialize [
	| v |
	v := STurtleVarDef new.
	self assert: v privVarNames size equals: 5.
	self assert: (v includes: 'color').
	self assert: (v includes: 'flag').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').
	self assert: (v includes: 'heading').
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testPenDownFlagNo [
	self assert: STurtleVarDef penDownFlagNo equals: 1.
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testXVarNo [
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'x') equals: STurtleVarDef xVarNo.
]

{ #category : #'tests-accessing' }
STurtleVarDefTest >> testYVarNo [
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'y') equals: STurtleVarDef yVarNo.
]
