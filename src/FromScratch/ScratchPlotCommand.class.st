Class {
	#name : #ScratchPlotCommand,
	#superclass : #ScratchPlot,
	#instVars : [
		'command',
		'args'
	],
	#category : #'FromScratch-Plotter'
}

{ #category : #private }
ScratchPlotCommand class >> clearPlotNo [
	^ 1
]

{ #category : #private }
ScratchPlotCommand class >> setPlotYMax [
	^ 3
]

{ #category : #private }
ScratchPlotCommand class >> setPlotYMin [
	^ 2
]

{ #category : #operations }
ScratchPlotCommand >> applyTo: aPlotter [
	self isClearPlot
		ifTrue: [ ^ aPlotter clearPlots ].
	self isSetPlotYMax
		ifTrue: [ ^ aPlotter max: args first ].
	self isSetPlotYMin
		ifTrue: [ ^ aPlotter min: args first ]
]

{ #category : #accessing }
ScratchPlotCommand >> args [
	^ args
]

{ #category : #accessing }
ScratchPlotCommand >> args: aCollection [
	args := aCollection copy
]

{ #category : #accessing }
ScratchPlotCommand >> command [
	^ command
]

{ #category : #accessing }
ScratchPlotCommand >> command: anObject [
	command := anObject
]

{ #category : #testing }
ScratchPlotCommand >> isClearPlot [
	^ self command = self class clearPlotNo
]

{ #category : #testing }
ScratchPlotCommand >> isSetPlotYMax [
	^ self command = self class setPlotYMax
]

{ #category : #testing }
ScratchPlotCommand >> isSetPlotYMin [
	^ self command = self class setPlotYMin
]
