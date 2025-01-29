Class {
	#name : 'ScratchPlotColor',
	#superclass : 'ScratchPlot',
	#instVars : [
		'channel',
		'color'
	],
	#category : 'FromScratch-Plotter',
	#package : 'FromScratch',
	#tag : 'Plotter'
}

{ #category : 'operations' }
ScratchPlotColor >> applyTo: aPlotter [
	aPlotter addPen: channel color: color
]

{ #category : 'accessing' }
ScratchPlotColor >> channel [
	^ channel
]

{ #category : 'accessing' }
ScratchPlotColor >> channel: anObject [
	channel := anObject
]

{ #category : 'accessing' }
ScratchPlotColor >> color [
	^ color
]

{ #category : 'accessing' }
ScratchPlotColor >> color: anObject [
	color := anObject
]
