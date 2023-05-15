"
A STurtleVarIdTest is a test class for testing the behavior of STurtleVarId
"
Class {
	#name : #STurtlesVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testAliveFlagNo [
	self assert: STurtlesVarDef aliveFlagNo equals: 0.
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testClassNameFor [
	| pv |
	pv := STurtlesVarDef new.
	self assert: (pv classNameFor: 'color') equals: #ByteArray.
	self assert: (pv classNameFor: 'flag') equals: #ByteArray.
	self assert: (pv classNameFor: 'x') equals: #Float32Array.
	self assert: (pv classNameFor: 'y') equals: #Float32Array.
	self assert: (pv classNameFor: 'heading') equals: #Float32Array
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testColorVarNo [

	| v |
	v := STurtlesVarDef new.
	self assert: (v varNoFor: 'color') equals: STurtlesVarDef colorVarNo.
	self assert: STurtlesVarDef colorVarNo equals: 1
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testFlagVarNo [
	| v |
	v := STurtlesVarDef new.
	self assert: (v varNoFor: 'flag') equals: STurtlesVarDef flagVarNo.
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testHeadingVarNo [
	| v |
	v := STurtlesVarDef new.
	self assert: (v varNoFor: 'heading') equals: STurtlesVarDef headingVarNo.
]

{ #category : #'tests-initialization' }
STurtlesVarDefTest >> testInitialize [
	| v |
	v := STurtlesVarDef new.
	self assert: v privVarNames size equals: 5.
	self assert: (v includes: 'color').
	self assert: (v includes: 'flag').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').
	self assert: (v includes: 'heading').
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testPenDownFlagNo [
	self assert: STurtlesVarDef penDownFlagNo equals: 1.
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testXVarNo [
	| v |
	v := STurtlesVarDef new.
	self assert: (v varNoFor: 'x') equals: STurtlesVarDef xVarNo.
]

{ #category : #'tests-accessing' }
STurtlesVarDefTest >> testYVarNo [
	| v |
	v := STurtlesVarDef new.
	self assert: (v varNoFor: 'y') equals: STurtlesVarDef yVarNo.
]
