Class {
	#name : 'ScratchPlot',
	#superclass : 'Object',
	#category : 'FromScratch-Plotter',
	#package : 'FromScratch',
	#tag : 'Plotter'
}

{ #category : 'instance creation' }
ScratchPlot class >> channel: anInteger color: aColor [
	^ ScratchPlotColor new
		channel: anInteger;
		color: aColor ;
		yourself
]

{ #category : 'instance creation' }
ScratchPlot class >> channel: anInteger data: aFloat [
	^ ScratchPlotData new
		channel: anInteger;
		data: aFloat;
		yourself
]

{ #category : 'instance creation' }
ScratchPlot class >> clearPlots [
	^ ScratchPlotCommand new
		command: ScratchPlotCommand clearPlotNo;
		yourself
]

{ #category : 'instance creation' }
ScratchPlot class >> setPlotYMax: aNumber [
	^ ScratchPlotCommand new
		command: ScratchPlotCommand setPlotYMax;
		args: { aNumber };
		yourself
]

{ #category : 'instance creation' }
ScratchPlot class >> setPlotYMin: aNumber [
	^ ScratchPlotCommand new
		command: ScratchPlotCommand setPlotYMin;
		args: { aNumber };
		yourself
]

{ #category : 'operations' }
ScratchPlot >> applyTo: aPlotter [
	self subclassResponsibility
]
