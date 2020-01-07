Class {
	#name : #SteloPlotCommand,
	#superclass : #SteloPlot,
	#instVars : [
		'command',
		'args'
	],
	#category : #'Stelo-Model'
}

{ #category : #private }
SteloPlotCommand class >> clearPlotNo [
	^ 1
]

{ #category : #private }
SteloPlotCommand class >> setPlotYMax [
	^ 3
]

{ #category : #private }
SteloPlotCommand class >> setPlotYMin [
	^ 2
]

{ #category : #operations }
SteloPlotCommand >> applyTo: aPlotter [
	self isClearPlot
		ifTrue: [ ^ aPlotter clearPlots ].
	self isSetPlotYMax
		ifTrue: [ ^ aPlotter max: args first ].
	self isSetPlotYMin
		ifTrue: [ ^ aPlotter min: args first ]
]

{ #category : #accessing }
SteloPlotCommand >> args [
	^ args
]

{ #category : #accessing }
SteloPlotCommand >> args: aCollection [
	args := aCollection copy
]

{ #category : #accessing }
SteloPlotCommand >> command [
	^ command
]

{ #category : #accessing }
SteloPlotCommand >> command: anObject [
	command := anObject
]

{ #category : #testing }
SteloPlotCommand >> isClearPlot [
	^ self command = self class clearPlotNo
]

{ #category : #testing }
SteloPlotCommand >> isSetPlotYMax [
	^ self command = self class setPlotYMax
]

{ #category : #testing }
SteloPlotCommand >> isSetPlotYMin [
	^ self command = self class setPlotYMin
]
