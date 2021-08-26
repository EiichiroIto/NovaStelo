Class {
	#name : #SpScratchEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'labelStatus',
		'editor',
		'target',
		'labelName',
		'notebook'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpScratchEditor class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #labelName;
				add: #labelStatus;
				yourself)
			withConstraints: [ :c | c expand: false ];
		add: #notebook;
		yourself
]

{ #category : #accessing }
SpScratchEditor >> cleanUp [
	^ self editorContents cleanUp
]

{ #category : #private }
SpScratchEditor >> createEditorPage [
	editor := self newMorph.
	editor
		morph:
			(ScrollFrameMorph2 new
				growthFraction: 0.1;
				color: ScratchTheme scriptsPaneColor).
	^ SpNotebookPage
		title: self scriptsLabel
		icon: (self iconNamed: #morph)
		provider: [ editor ]
]

{ #category : #private }
SpScratchEditor >> editorContents [
	^ editor morph contents
]

{ #category : #private }
SpScratchEditor >> editorContents: aMorph [
	editor morph contents: aMorph
]

{ #category : #initialization }
SpScratchEditor >> initializePresenters [
	labelName := self newLabel.
	labelStatus := self newLabel.
	notebook := self newNotebook.
	notebook addPage: self createEditorPage
]

{ #category : #accessing }
SpScratchEditor >> screenshot [
	^ self editorContents screenshot
]

{ #category : #private }
SpScratchEditor >> scriptsLabel [
	^ 'Scripts'
]

{ #category : #accessing }
SpScratchEditor >> status [
	^ labelStatus label asString
]

{ #category : #accessing }
SpScratchEditor >> status: aString [
	labelStatus label: aString
]

{ #category : #accessing }
SpScratchEditor >> tab: aString [
	self target ifNil: [ ^ self ].
	self editorContents: self target blocksBin.
	self editorContents color: ScratchTheme scriptsPaneColor.
	notebook pages
		detect: [ :page | page title = aString ]
		ifFound: [ :page | notebook selectPage: page ]
]

{ #category : #accessing }
SpScratchEditor >> target [
	^ target
]

{ #category : #accessing }
SpScratchEditor >> target: aScratchObjectOrNil [
	target := aScratchObjectOrNil.
	aScratchObjectOrNil
		ifNil: [ labelName label: 'no object' localized.
			self editorContents: (Morph new color: Color red).
			^ self ].
	labelName label: aScratchObjectOrNil objName.
	self tab: self scriptsLabel
]
