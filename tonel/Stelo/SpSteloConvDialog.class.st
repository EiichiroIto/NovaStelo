Class {
	#name : #SpSteloConvDialog,
	#superclass : #SpPresenter,
	#instVars : [
		'dropListNames',
		'dropPlots',
		'labelListNames',
		'labelPlots'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #specs }
SpSteloConvDialog class >> defaultSpec [
	^ self listToPlotSpec
]

{ #category : #'instance creation' }
SpSteloConvDialog class >> listNames: listNames plots: plots [
	| dialog |
	dialog := self new
		listNames: listNames;
		plots: plots;
		yourself.
	(dialog openModalWithSpec: #listToPlotSpec) isCancelled
		ifTrue: [ ^ nil ].
	^ {dialog listName.
	dialog plot}
]

{ #category : #specs }
SpSteloConvDialog class >> listToPlotSpec [
	^ SpBoxLayout newVertical
		spacing: 4;
		add: #labelListNames withConstraints: [ :c | c expand: false ];
		add: #dropListNames withConstraints: [ :c | c expand: false ];
		add: #labelPlots withConstraints: [ :c | c expand: false ];
		add: #dropPlots withConstraints: [ :c | c expand: false ];
		yourself
]

{ #category : #specs }
SpSteloConvDialog class >> plotToListSpec [
	^ SpBoxLayout newVertical
		spacing: 4;
		add: #labelPlots withConstraints: [ :c | c expand: false ];
		add: #dropPlots withConstraints: [ :c | c expand: false ];
		add: #labelListNames withConstraints: [ :c | c expand: false ];
		add: #dropListNames withConstraints: [ :c | c expand: false ];
		yourself
]

{ #category : #'instance creation' }
SpSteloConvDialog class >> plots: plots listNames: listNames [
	| dialog |
	dialog := self new
		listNames: listNames;
		plots: plots;
		yourself.
	(dialog openModalWithSpec: #plotToListSpec) isCancelled
		ifTrue: [ ^ nil ].
	^ {dialog plot.
	dialog listName}
]

{ #category : #initialization }
SpSteloConvDialog >> connectPresenters [
	dropPlots display: [ :m | self showPlotsNumber: m ]
]

{ #category : #initialization }
SpSteloConvDialog >> initializePresenters [
	dropListNames := self newDropList.
	dropPlots := self newDropList.
	labelListNames := self newLabel.
	labelPlots := self newLabel.
	labelListNames label: 'list names' translated.
	labelPlots label: 'plot numbers' translated.
	self focusOrder
		add: dropListNames;
		add: dropPlots
]

{ #category : #accessing }
SpSteloConvDialog >> listName [
	^ dropListNames selectedItem
]

{ #category : #accessing }
SpSteloConvDialog >> listNames: aCollection [
	dropListNames
		selectIndex: 0;
		items: aCollection
]

{ #category : #accessing }
SpSteloConvDialog >> plot [
	^ dropPlots selectedItem
]

{ #category : #accessing }
SpSteloConvDialog >> plots: aCollection [
	dropPlots
		selectIndex: 0;
		items: aCollection
]

{ #category : #private }
SpSteloConvDialog >> showPlotsNumber: anInteger [
	^ anInteger asString
]
