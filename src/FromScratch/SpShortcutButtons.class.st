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
	buttonComputer := self newButton label: 'Computer'.
	buttonUser := self newButton label: 'User'.
	buttonDesktop := self newButton label: 'Desktop'.
	buttonExamples := self newButton label: 'Examples'.
	buttonProjects := self newButton label: 'My Projects'.
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
