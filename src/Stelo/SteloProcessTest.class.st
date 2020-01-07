"
A SteloProcessTest is a test class for testing the behavior of SteloProcess
"
Class {
	#name : #SteloProcessTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-private' }
SteloProcessTest >> testPrivSWorld [
	| w p |
	w := SMicroWorld new.
	p := SteloProcess new.
	self assert: p privSWorld isNil.
	p privSWorld: w.
	self assert: p privSWorld equals: w.
]

{ #category : #'tests-private' }
SteloProcessTest >> testProgram [
	| pr p |
	pr := SProgram new.
	p := SteloProcess new program: pr.
	self assert: p program equals: pr.
]
