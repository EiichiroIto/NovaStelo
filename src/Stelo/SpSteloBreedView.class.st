Class {
	#name : #SpSteloBreedView,
	#superclass : #SpPresenter,
	#instVars : [
		'labelVars',
		'buttonDelete',
		'tableVars',
		'whenDeletedDo',
		'title',
		'getValuesBlock',
		'buttonRefresh'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #specs }
SpSteloBreedView class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #labelVars withConstraints: [ :c | c expand: false ];
		add: #tableVars;
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #buttonRefresh;
				add: #buttonDelete;
				yourself) withConstraints: [ :c | c expand: false ];
		yourself
]

{ #category : #specs }
SpSteloBreedView class >> noDeleteButtonSpec [
	^ SpBoxLayout newVertical
		add: #labelVars withConstraints: [ :c | c expand: false ];
		add: #tableVars;
		add:
			(SpBoxLayout newHorizontal
				add: #buttonRefresh;
				yourself) withConstraints: [ :c | c expand: false ];
		yourself
]

{ #category : #initialization }
SpSteloBreedView >> connectPresenters [
	buttonDelete action: [ self delete ].
	buttonRefresh action: [ self updateTable ]
]

{ #category : #private }
SpSteloBreedView >> delete [
	super delete.
	whenDeletedDo ifNotNil: [ whenDeletedDo value ]
]

{ #category : #private }
SpSteloBreedView >> getNameOf: anObject [
	^ anObject first asString
]

{ #category : #private }
SpSteloBreedView >> getValueOf: anObject [
	^ anObject second asString
]

{ #category : #accessing }
SpSteloBreedView >> getValuesBlock [
	^ getValuesBlock
]

{ #category : #accessing }
SpSteloBreedView >> getValuesBlock: aBlock [
	getValuesBlock := aBlock
]

{ #category : #initialization }
SpSteloBreedView >> initializePresenters [
	tableVars := self newTable.
	labelVars := self newLabel.
	buttonRefresh := self newButton.
	buttonDelete := self newButton.
	tableVars
		addColumn:
			(SpStringTableColumn
				title: 'Name'
				evaluated: [ :o | self getNameOf: o ]);
		addColumn:
			(SpStringTableColumn
				title: 'Value'
				evaluated: [ :o | self getValueOf: o ]).
	labelVars label: 'Variables'.
	buttonRefresh
		label: 'Refresh';
		icon: (self iconNamed: #refresh).
	buttonDelete
		label: 'Delete';
		icon: (self iconNamed: #delete).
	self focusOrder
		add: tableVars;
		add: buttonRefresh;
		add: buttonDelete
]

{ #category : #initialization }
SpSteloBreedView >> initializeWindow: aWindow [
	aWindow title: title.
	self updateTable
]

{ #category : #accessing }
SpSteloBreedView >> title [
	^ title
]

{ #category : #accessing }
SpSteloBreedView >> title: aString [
	title := aString
]

{ #category : #private }
SpSteloBreedView >> updateTable [
	tableVars
		items: (getValuesBlock ifNotNil: [ getValuesBlock value ] ifNil: [ #() ])
]

{ #category : #accessing }
SpSteloBreedView >> values [
	^ tableVars items
]

{ #category : #accessing }
SpSteloBreedView >> whenDeletedDo [
	^ whenDeletedDo
]

{ #category : #accessing }
SpSteloBreedView >> whenDeletedDo: aBlock [
	whenDeletedDo := aBlock
]
