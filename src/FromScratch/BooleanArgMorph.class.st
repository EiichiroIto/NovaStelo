Class {
	#name : #BooleanArgMorph,
	#superclass : #ArgMorph,
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
BooleanArgMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #other }
BooleanArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the givent type."

	^ aBlockMorph isBooleanReporter

]

{ #category : #'code generation' }
BooleanArgMorph >> argString: aGenerator [
	^ aGenerator booleanArgString: self.
]

{ #category : #drawing }
BooleanArgMorph >> drawOn: aCanvas [ 

	| h s v darkerC lighterC right topY bottomY xInset c |
	h := color hue.
	s := color saturation.
	v := color brightness.
	darkerC := Color h: h s: (s - 0.3) v: (v - 0.3).
	lighterC := Color h: h s: (s - 0.2) v: (v + 0.2).

	right := self width.
	topY := bottomY := self height // 2.
	self height even ifTrue: [topY := bottomY - 1].
	xInset := 0.
	[topY >= 0] whileTrue: [
		self drawHLineFrom: xInset to: (xInset + 2) y: topY color: darkerC on: aCanvas.
		c := (topY <= 1) ifTrue: [darkerC] ifFalse: [color].
		self drawHLineFrom: xInset + 2 to: right - (xInset + 1) y: topY color: c on: aCanvas.
		self drawHLineFrom: (right - (xInset + 1)) to: (right - xInset) y: topY color: darkerC on: aCanvas.

		self drawHLineFrom: xInset to: (xInset + 1) y: bottomY color: lighterC on: aCanvas.
		c := (bottomY >= (self height - 2)) ifTrue: [lighterC] ifFalse: [color].
		self drawHLineFrom: xInset + 1 to: right - (xInset + 1) y: bottomY color: c on: aCanvas.
		self drawHLineFrom: (right - (xInset + 2)) to: (right - xInset) y: bottomY color: lighterC on: aCanvas.

		xInset := xInset + 1.	
		bottomY := bottomY + 1.
		topY := topY - 1].


]

{ #category : #evaluation }
BooleanArgMorph >> evaluate [
	"Answer false by default."

	^ false

]

{ #category : #other }
BooleanArgMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.7 with: (Color gray: 0.4)).

]

{ #category : #initialization }
BooleanArgMorph >> initialize [

	super initialize.
	self color: (Color r: 0.451 g: 0.866 b: 0.109).
	self extent: 25@13.

]
