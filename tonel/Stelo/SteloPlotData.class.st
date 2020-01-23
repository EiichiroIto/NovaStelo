Class {
	#name : #SteloPlotData,
	#superclass : #SteloPlot,
	#instVars : [
		'channel',
		'data'
	],
	#category : #'Stelo-Model'
}

{ #category : #operations }
SteloPlotData >> applyTo: aPlotter [
	aPlotter plot: channel data: data
]

{ #category : #accessing }
SteloPlotData >> channel [
	^ channel
]

{ #category : #accessing }
SteloPlotData >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
SteloPlotData >> data [
	^ data
]

{ #category : #accessing }
SteloPlotData >> data: anObject [
	data := anObject
]
