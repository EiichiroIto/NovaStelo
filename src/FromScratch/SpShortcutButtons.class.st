Class {
	#name : #SpShortcutButtons,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonComputer',
		'buttonUser',
		'buttonDesktop',
		'buttonExamples',
		'buttonProjects',
		'list'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpShortcutButtons class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 2;
		add: #buttonComputer;
		add: #buttonUser;
		add: #buttonDesktop;
		add: #buttonExamples;
		add: #buttonProjects;
		yourself
]

{ #category : #initialization }
SpShortcutButtons >> connectPresenters [
	buttonComputer action: [ self setDirectoryType: #computer ].
	buttonUser action: [ self setDirectoryType: #user ].
	buttonDesktop action: [ self setDirectoryType: #desktop ].
	buttonExamples action: [ self setDirectoryType: #examples ].
	buttonProjects action: [ self setDirectoryType: #project ]
]

{ #category : #initialization }
SpShortcutButtons >> initializePresenters [
	| blank |
	blank := Smalltalk ui iconNamed: #blank.
	buttonComputer := self newButton
		label: 'Computer' localized;
		icon: blank.
	buttonUser := self newButton
		label: 'User' localized;
		icon: blank.
	buttonDesktop := self newButton
		label: 'Desktop' localized;
		icon: blank.
	buttonExamples := self newButton
		label: 'Examples' localized;
		icon: blank.
	buttonProjects := self newButton
		label: 'My Projects' localized;
		icon: blank.
	self focusOrder
		add: buttonComputer;
		add: buttonUser;
		add: buttonDesktop;
		add: buttonExamples;
		add: buttonProjects
]

{ #category : #accessing }
SpShortcutButtons >> list [
	^ list
]

{ #category : #accessing }
SpShortcutButtons >> list: aSpPresenter [
	list := aSpPresenter
]

{ #category : #private }
SpShortcutButtons >> setDirectory: aFileReference [
	list ifNil: [ ^ self ].
	aFileReference ifNil: [ ^ self ].
	list directory: aFileReference
]

{ #category : #private }
SpShortcutButtons >> setDirectoryType: aSymbol [
	| dir |
	dir := 	ScratchDirectory current perform: aSymbol.
	self setDirectory: dir
]

{ #category : #accessing }
SpShortcutButtons >> userName: aString [
	buttonUser label: aString
]
