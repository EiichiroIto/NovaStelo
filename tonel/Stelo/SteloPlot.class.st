Class {
	#name : #SteloPlot,
	#superclass : #Object,
	#category : #'Stelo-Model'
}

{ #category : #'instance creation' }
SteloPlot class >> channel: anInteger colorAt: color [
	^ SteloPlotColor new
		channel: anInteger;
		color: (SColorList colorAt: color) ;
		yourself
]

{ #category : #'instance creation' }
SteloPlot class >> channel: anInteger data: aFloat [
	^ SteloPlotData new
		channel: anInteger;
		data: aFloat;
		yourself
]

{ #category : #'instance creation' }
SteloPlot class >> clearPlots [
	^ SteloPlotCommand new
		command: SteloPlotCommand clearPlotNo;
		yourself
]

{ #category : #'instance creation' }
SteloPlot class >> setPlotYMax: aNumber [
	^ SteloPlotCommand new
		command: SteloPlotCommand setPlotYMax;
		args: { aNumber };
		yourself
]

{ #category : #'instance creation' }
SteloPlot class >> setPlotYMin: aNumber [
	^ SteloPlotCommand new
		command: SteloPlotCommand setPlotYMin;
		args: { aNumber };
		yourself
]

{ #category : #operations }
SteloPlot >> applyTo: aPlotter [
	self subclassResponsibility
]
