"
A ScratchPlotColorTest is a test class for testing the behavior of ScratchPlotColor
"
Class {
	#name : #ScratchPlotColorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchPlotColorTest >> newPlotColor [
	^ ScratchPlotColor new
]

{ #category : #test }
ScratchPlotColorTest >> testChannel [
	| p |
	p := self newPlotColor.
	self assert: p channel isNil.
	p channel: 1.
	self assert: p channel equals: 1.
	p channel: 2.
	self assert: p channel equals: 2
]

{ #category : #test }
ScratchPlotColorTest >> testColor [
	| p |
	p := self newPlotColor.
	self assert: p color isNil.
	p color: Color red.
	self assert: p color equals: Color red.
	p color: Color blue.
	self assert: p color equals: Color blue
]
