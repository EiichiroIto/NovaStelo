Class {
	#name : #SpScratchViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'currentCategory',
		'pageViewer',
		'target'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #private }
SpScratchViewer class >> addButtonsTo: aLayout [
	| w |
	w := SpScratchFrame viewerPaneWidth // 2.
	self buttons
		pairsDo: [ :each1 :each2 | 
			aLayout
				add:
					(SpBoxLayout newHorizontal
						add: each1 first withConstraints: [ :c | c width: w ];
						add: each2 first withConstraints: [ :c | c width: w ];
						yourself)
				withConstraints: [ :c | c height: self buttonHeight ] ]
]

{ #category : #accessing }
SpScratchViewer class >> buttons [
	self subclassResponsibility
]

{ #category : #specs }
SpScratchViewer class >> defaultSpec [
	| myLayout |
	myLayout := SpBoxLayout newVertical.
	self addButtonsTo: myLayout.
	myLayout add: #pageViewer.
	^ myLayout
]

{ #category : #accessing }
SpScratchViewer >> currentCategory [
	^ currentCategory ifNil: [ #none ]
]

{ #category : #accessing }
SpScratchViewer >> currentCategory: aString [
	currentCategory := aString asLowercase.
	self updateButtons.
	self updateContents
]

{ #category : #initialization }
SpScratchViewer >> initializePresenters [
	pageViewer := self newMorph.
	pageViewer morph: (ScrollFrameMorph2 new growthFraction: 0.1).
	self setupButtons.
	self updateButtons
]

{ #category : #private }
SpScratchViewer >> pageViewerContents: aMorph [
	pageViewer morph contents: aMorph
]

{ #category : #private }
SpScratchViewer >> selectButton: aSymbol [
	| button |
	button := self instVarNamed: aSymbol.
	button state: currentCategory = button label asString asLowercase
]

{ #category : #private }
SpScratchViewer >> setupButtons [
	self subclassResponsibility
]

{ #category : #accessing }
SpScratchViewer >> target [
	^ target
]

{ #category : #accessing }
SpScratchViewer >> target: anObject [
	| categories |
	target := anObject.
	target ifNil: [ ^ self currentCategory: nil ].
	categories := target blockCategories.
	self
		currentCategory:
			((categories includes: currentCategory)
				ifTrue: [ currentCategory ]
				ifFalse: [ categories first ])
]

{ #category : #private }
SpScratchViewer >> updateButtons [
	self class buttons
		do: [ :each | 
			| name |
			self selectButton: each first.
			name := each second.
			(self instVarNamed: each first)
				icon:
					(ScratchTheme
						formAt:
							(name asLowercase = currentCategory
								ifTrue: [ (name , 'Pressed') asSymbol ]
								ifFalse: [ name ])) ]
]

{ #category : #private }
SpScratchViewer >> updateContents [
	| p |
	p := self target
		ifNil: [ Morph new ]
		ifNotNil: [ self target viewerPageForCategory: currentCategory ].
	p color: ScratchTheme palettePaneColor.
	p fixLayout.
	self pageViewerContents: p
]
