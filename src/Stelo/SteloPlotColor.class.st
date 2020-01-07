Class {
	#name : #SteloPlotColor,
	#superclass : #SteloPlot,
	#instVars : [
		'channel',
		'color'
	],
	#category : #'Stelo-Model'
}

{ #category : #operations }
SteloPlotColor >> applyTo: aPlotter [
	aPlotter addPen: channel color: color
]

{ #category : #accessing }
SteloPlotColor >> channel [
	^ channel
]

{ #category : #accessing }
SteloPlotColor >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
SteloPlotColor >> color [
	^ color
]

{ #category : #accessing }
SteloPlotColor >> color: anObject [
	color := anObject
]
