Class {
	#name : #SpSteloInspector,
	#superclass : #SpPresenter,
	#instVars : [
		'tableVars',
		'buttonEdit',
		'buttonDelete'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #specs }
SpSteloInspector class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 4;
		add: #tableVars;
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #buttonEdit;
				add: #buttonDelete;
				yourself)
			withConstraints: [ :c | c expand: false ];
		yourself
]

{ #category : #initialization }
SpSteloInspector >> initializePresenters [
	tableVars := self newTable.
	buttonEdit := self newButton.
	buttonDelete := self newButton.
	tableVars
		activateOnDoubleClick;
		addColumn:
			(SpStringTableColumn
				title: 'Name' localized
				evaluated: [ :o | o first asString ]);
		addColumn:
			(SpStringTableColumn
				title: 'Value' localized
				evaluated: [ :o | o second asString ]).
	buttonEdit
		label: 'Edit' localized;
		icon: (self iconNamed: #edit).
	buttonDelete
		label: 'Delete' localized;
		icon: (self iconNamed: #delete).
	self focusOrder
		add: tableVars;
		add: buttonEdit;
		add: buttonDelete
]

{ #category : #accessing }
SpSteloInspector >> items: aCollection [
	tableVars items: aCollection
]

{ #category : #accessing }
SpSteloInspector >> selectedIndex: anInteger [
	tableVars selectIndex: anInteger
]

{ #category : #accessing }
SpSteloInspector >> whenActivatedDo: aBlock [
	tableVars whenActivatedDo: aBlock
]

{ #category : #accessing }
SpSteloInspector >> whenDeleteDo: aBlock [
	buttonDelete action: aBlock
]

{ #category : #accessing }
SpSteloInspector >> whenEditDo: aBlock [
	buttonEdit action: [ aBlock cull: tableVars selection selectedItem ]
]
