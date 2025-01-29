Class {
	#name : 'SpMultiSelectDialog',
	#superclass : 'SpDialogPresenter',
	#instVars : [
		'label',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel',
		'table',
		'selectedItems'
	],
	#category : 'FromScratch-Spec2',
	#package : 'FromScratch',
	#tag : 'Spec2'
}

{ #category : 'accessing' }
SpMultiSelectDialog class >> defaultExtent [

	^ 450@300
]

{ #category : 'layout' }
SpMultiSelectDialog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #table;
		yourself
]

{ #category : 'documentation' }
SpMultiSelectDialog class >> documentFactoryMethodSelector [
	
	^ #newMultiSelect
]

{ #category : 'examples' }
SpMultiSelectDialog class >> example [

	self new
		title: 'Select example';
		label: 'Select classes';
		items: Smalltalk allClassesAndTraits;
		selectedItems: Set new;
		display: [ :each | each name ];
		onAccept: [ :dialog | self inform: dialog presenter selectedItems asString ];
		openDialog
]

{ #category : 'examples' }
SpMultiSelectDialog class >> exampleModal [

	| selections |
	selections := self new
		              title: 'Select modal example';
		              label: 'Select classes';
		              items: Smalltalk allClassesAndTraits;
		              selectedItems: Set new;
		              display: [ :each | each name ];
		              openModal.

	selections ifNotNil: [ self inform: selections asString ]
]

{ #category : 'api' }
SpMultiSelectDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : 'api' }
SpMultiSelectDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : 'api' }
SpMultiSelectDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : 'api' }
SpMultiSelectDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : 'api' }
SpMultiSelectDialog >> display: aBlock [

	table columns second evaluated: aBlock
]

{ #category : 'api' }
SpMultiSelectDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : 'api' }
SpMultiSelectDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : 'initialization' }
SpMultiSelectDialog >> initialize [
	
	super initialize.
	self title: 'Request'.
	selectedItems := Set new
]

{ #category : 'initialization' }
SpMultiSelectDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | self cancel ];
		addDefaultButton: self acceptLabel do: [ :presenter | self accept ]
]

{ #category : 'initialization' }
SpMultiSelectDialog >> initializePresenters [

	label := self newLabel.
	table := self newTable.

	table
		addColumn: ((SpCheckBoxTableColumn
				  title: ' '
				  evaluated: [ :obj | selectedItems includes: obj ])
				 onActivation: [ :obj | selectedItems add: obj ];
				 onDeactivation: [ :obj | selectedItems remove: obj ];
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn title: 'Name');
		beResizable
]

{ #category : 'initialization' }
SpMultiSelectDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ table takeKeyboardFocus ]
]

{ #category : 'api' }
SpMultiSelectDialog >> items [

	^ table items
]

{ #category : 'api' }
SpMultiSelectDialog >> items: aCollection [

	table items: aCollection
]

{ #category : 'api' }
SpMultiSelectDialog >> label: aString [

	label label: aString
]

{ #category : 'api - showing' }
SpMultiSelectDialog >> openModal [
	| dialog |
	
	dialog := super openModal.
	^ dialog isOk
		ifTrue: [ self selectedItems ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
SpMultiSelectDialog >> selectedItems [

	^ selectedItems
]

{ #category : 'accessing' }
SpMultiSelectDialog >> selectedItems: anObject [

	selectedItems := anObject asSet copy
]

{ #category : 'api' }
SpMultiSelectDialog >> title [

	^ title
]

{ #category : 'api' }
SpMultiSelectDialog >> title: aString [

	title := aString
]
