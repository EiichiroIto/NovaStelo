"
A SColorListTest is a test class for testing the behavior of SColorList
"
Class {
	#name : #SColorListTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #tests }
SColorListTest >> testScaleGrayscaleFromTo [
	| br c |
	br := SColorList.
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

{ #category : #tests }
SColorListTest >> testScaleValueColorFromTo [
	| br c |
	br := SColorList.
	c := br scaleValue: 0 color: 35 from: 0 to: 0.
	self assert: c equals: SColorList black.
	c := br scaleValue: 0 color: 35 from: 1 to: 9.
	self assert: c equals: SColorList black.
	c := br scaleValue: 10 color: 35 from: 1 to: 9.
	self assert: c equals: SColorList white.
	c := br scaleValue: 5 color: 35 from: 1 to: 9.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 1 to: 9.
	self assert: c equals: 30.
	c := br scaleValue: 9 color: 35 from: 1 to: 9.
	self assert: c equals: 39.

	c := br scaleValue: 10 color: 35 from: 9 to: 1.
	self assert: c equals: SColorList black.
	c := br scaleValue: 0 color: 35 from: 9 to: 1.
	self assert: c equals: SColorList white.
	c := br scaleValue: 5 color: 35 from: 9 to: 1.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 9 to: 1.
	self assert: c equals: 39.
	c := br scaleValue: 9 color: 35 from: 9 to: 1.
	self assert: c equals: 30.
]
