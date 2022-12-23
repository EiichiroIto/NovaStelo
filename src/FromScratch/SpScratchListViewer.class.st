Class {
	#name : #SpScratchListViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'categories',
		'pageViewer',
		'target'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #layout }
SpScratchListViewer class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #categories height: 200;
		add: #pageViewer;
		yourself
]

{ #category : #accessing }
SpScratchListViewer >> categories: aCollection [
	categories items: (aCollection collect: [ :each | each asLowercase ]) sort
]

{ #category : #initialization }
SpScratchListViewer >> connectPresenters [
	categories
		display: [ :each | each asString localized ];
		displayIcon: [ :each | self markerFormFor: each ];
		whenSelectionChangedDo: [ :each | self updateContents ]
]

{ #category : #accessing }
SpScratchListViewer >> currentCategory [
	^ categories selection selectedItem
]

{ #category : #accessing }
SpScratchListViewer >> currentCategory: aString [
	aString ifNil: [ ^ self ].
	categories selectItem: aString asLowercase
]

{ #category : #initialization }
SpScratchListViewer >> initializePresenters [
	pageViewer := self newMorph.
	pageViewer morph: (ScrollFrameMorph new growthFraction: 0.1).
	categories := self newList
		beSingleSelection;
		yourself
]

{ #category : #private }
SpScratchListViewer >> markerFormFor: aString [
	| color canvas |
	color := self target blockColorFor: aString.
	canvas := FormCanvas extent: 13 @ 13.
	canvas
		fillOval: (0 @ 0 corner: 12 @ 12)
		color: color
		borderWidth: 1
		borderColor: color darker.
	^ canvas form
]

{ #category : #accessing }
SpScratchListViewer >> target [
	^ target
]

{ #category : #accessing }
SpScratchListViewer >> target: anObject [
	| current |
	current := self currentCategory.
	target := anObject.
	target ifNil: [ ^ self currentCategory: nil ].
	self categories: target blockCategories.
	self currentCategory: current.
	self currentCategory ifNil: [ categories selectIndex: 1 ]
]

{ #category : #private }
SpScratchListViewer >> updateContents [
	| p |
	p := self target
		ifNil: [ ScratchBlockPaletteMorph new ]
		ifNotNil: [ self target viewerPageForCategory: self currentCategory ].
	p color: ScratchTheme palettePaneColor.
	p fixLayout.
	pageViewer morph contents: p
]
