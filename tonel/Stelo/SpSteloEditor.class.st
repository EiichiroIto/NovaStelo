Class {
	#name : #SpSteloEditor,
	#superclass : #SpScratchEditor,
	#instVars : [
		'plotter'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #accessing }
SpSteloEditor >> addPlots: aCollection [
	self plotterContents
		ifNotNil: [ :morph | morph addPlots: aCollection ]
]

{ #category : #private }
SpSteloEditor >> createPlotterPage [
	| morph |
	plotter := self newMorph.
	morph := ScrollFrameMorph2 new
		growthFraction: 0.1;
		color: Color black;
		yourself.
	morph contents color: (Color gray: 0.5).
	plotter morph: morph.
	^ SpNotebookPage
		title: self plotterLabel
		icon: (self iconNamed: #morph)
		provider: [ plotter ]
]

{ #category : #accessing }
SpSteloEditor >> currentTab: aString [
	super currentTab: aString.
	self target ifNil: [ ^ self ].
	self plotterContents: self target plotter
]

{ #category : #private }
SpSteloEditor >> defaultPlotterExtent [
	^ 100 @ 100
]

{ #category : #initialization }
SpSteloEditor >> initializePresenters [
	super initializePresenters.
	notebook addPage: self createPlotterPage.
	notebook whenSelectedPageChangedDo: [ :p | self pageSelected: p ]
]

{ #category : #private }
SpSteloEditor >> pageSelected: aNotebookPage [
	aNotebookPage title = self plotterLabel
		ifFalse: [ ^ self ].
	self plotterContents
		ifNotNil: [ :p | p bounds: (self plotterBase bounds insetBy: 5) ]
]

{ #category : #private }
SpSteloEditor >> plotterBase [
	^ plotter morph
]

{ #category : #accessing }
SpSteloEditor >> plotterContents [
	^ self plotterBase submorphs
		detect: [ :each | each isKindOf: SteloPlotterMorph ]
		ifNone: [ nil ]
]

{ #category : #accessing }
SpSteloEditor >> plotterContents: aPlotterMorph [
	| base |
	base := self plotterBase.
	base submorphs
		do: [ :each | 
			(each isKindOf: SteloPlotterMorph)
				ifTrue: [ each delete ] ].
	aPlotterMorph
		ifNotNil: [ base addMorph: aPlotterMorph ]
]

{ #category : #private }
SpSteloEditor >> plotterLabel [
	^ 'Plotter'
]
