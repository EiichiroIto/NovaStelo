Class {
	#name : 'SpSteloEditor',
	#superclass : 'SpScratchEditor',
	#instVars : [
		'plotter'
	],
	#category : 'Stelo-Spec2',
	#package : 'Stelo',
	#tag : 'Spec2'
}

{ #category : 'accessing' }
SpSteloEditor >> addPlots: aCollection [
	self plotter
		ifNotNil: [ :morph | morph addPlots: aCollection ]
]

{ #category : 'private' }
SpSteloEditor >> createPlotterPage [
	plotter := self newMorph.
	plotter morph: self newPlotter.
	^ SpNotebookPage
		title: self plotterLabel
		icon: (self iconNamed: #morph)
		provider: [ plotter ]
]

{ #category : 'initialization' }
SpSteloEditor >> initializePresenters [
	super initializePresenters.
	notebook addPage: self createPlotterPage
]

{ #category : 'private' }
SpSteloEditor >> newPlotter [
	^ ScratchPlotterMorph new
		updatePeriod: 3000;
		yourself
]

{ #category : 'accessing' }
SpSteloEditor >> plotter [
	^ plotter morph
]

{ #category : 'private' }
SpSteloEditor >> plotterLabel [
	^ 'Plotter' localized
]

{ #category : 'accessing' }
SpSteloEditor >> whenPlotterClicked: aBlock [
	self plotter whenMouseClicked: aBlock
]
