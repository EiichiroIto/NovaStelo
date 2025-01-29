Class {
	#name : 'ScratchPlotData',
	#superclass : 'ScratchPlot',
	#instVars : [
		'channel',
		'data'
	],
	#category : 'FromScratch-Plotter',
	#package : 'FromScratch',
	#tag : 'Plotter'
}

{ #category : 'operations' }
ScratchPlotData >> applyTo: aPlotter [
	aPlotter plot: channel data: data
]

{ #category : 'accessing' }
ScratchPlotData >> channel [
	^ channel
]

{ #category : 'accessing' }
ScratchPlotData >> channel: anObject [
	channel := anObject
]

{ #category : 'accessing' }
ScratchPlotData >> data [
	^ data
]

{ #category : 'accessing' }
ScratchPlotData >> data: anObject [
	data := anObject
]
