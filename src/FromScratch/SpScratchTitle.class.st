Class {
	#name : #SpScratchTitle,
	#superclass : #SpPresenter,
	#instVars : [
		'labelName',
		'toolBar'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #layout }
SpScratchTitle class >> defaultLayout [
	^ SpBoxLayout newHorizontal
		add: #labelName;
		add: #toolBar;
		yourself
]

{ #category : #private }
SpScratchTitle >> buttonNamed: aString [
	^ toolBar items detect: [ :each | each label = aString ]
]

{ #category : #initialization }
SpScratchTitle >> initializePresenters [
	labelName := self newLabel.
	labelName label: 'new project'.
	toolBar := self newToolbar.
	self setupButtons.
	self focusOrder add: toolBar
]

{ #category : #accessing }
SpScratchTitle >> projectName [
	^ labelName label asString
]

{ #category : #accessing }
SpScratchTitle >> projectName: aString [
	labelName label: aString asString
]

{ #category : #private }
SpScratchTitle >> setupButtons [
	"self subclassResponsibility"
]
