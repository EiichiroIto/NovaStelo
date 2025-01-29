"
A ColorListTest is a test class for testing the behavior of ColorList
"
Class {
	#name : 'ColorListTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'instance creation' }
ColorListTest >> newColorList [
	^ ColorList default
]

{ #category : 'test' }
ColorListTest >> testNearestColor [
	| c |
	c := self newColorList.
	self assert: (c nearestColor: Color black) equals: ColorList black.
	self assert: (c nearestColor: Color white) equals: ColorList white.
	self assert: (c nearestColor: Color red) equals: ColorList red.
	self assert: (c nearestColor: Color green) equals: ColorList green.
	self assert: (c nearestColor: Color blue) equals: ColorList blue.
]

{ #category : 'test' }
ColorListTest >> testScaleGrayscaleFromTo [
	| br c |
	br := ColorList.
	c := br scaleGrayscale: 0 from: 0 to: 0.
	self assert: c equals: 0.
	c := br scaleGrayscale: 0 from: 0 to: 100.
	self assert: c equals: 0.
	c := br scaleGrayscale: 100 from: 0 to: 100.
	self assert: c equals: 255.
	c := br scaleGrayscale: 50 from: 0 to: 100.
	self assert: c equals: 127.
	c := br scaleGrayscale: -1 from: 0 to: 100.
	self assert: c equals: 0.
	c := br scaleGrayscale: 101 from: 0 to: 100.
	self assert: c equals: 255.
	c := br scaleGrayscale: -1 from: 100 to: 0.
	self assert: c equals: 255.
	c := br scaleGrayscale: 101 from: 100 to: 0.
	self assert: c equals: 0
]

{ #category : 'test' }
ColorListTest >> testScaleValueColorFromTo [
	| br c |
	br := ColorList.
	c := br scaleValue: 0 color: 35 from: 0 to: 0.
	self assert: c equals: ColorList black.
	c := br scaleValue: 0 color: 35 from: 1 to: 9.
	self assert: c equals: ColorList black.
	c := br scaleValue: 10 color: 35 from: 1 to: 9.
	self assert: c equals: ColorList white.
	c := br scaleValue: 5 color: 35 from: 1 to: 9.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 1 to: 9.
	self assert: c equals: 30.
	c := br scaleValue: 9 color: 35 from: 1 to: 9.
	self assert: c equals: 39.

	c := br scaleValue: 10 color: 35 from: 9 to: 1.
	self assert: c equals: ColorList black.
	c := br scaleValue: 0 color: 35 from: 9 to: 1.
	self assert: c equals: ColorList white.
	c := br scaleValue: 5 color: 35 from: 9 to: 1.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 9 to: 1.
	self assert: c equals: 39.
	c := br scaleValue: 9 color: 35 from: 9 to: 1.
	self assert: c equals: 30.
]
