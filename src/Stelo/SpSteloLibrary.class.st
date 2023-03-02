Class {
	#name : #SpSteloLibrary,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonObserver',
		'buttonPatches',
		'buttonTurtles',
		'buttonAddTurtles',
		'buttonDeleteTurtles',
		'turtles',
		'whenTurtlesSelectedDo',
		'whenTurtlesAddedDo',
		'whenTurtlesDeletedDo'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #layout }
SpSteloLibrary class >> defaultLayout [
	^ SpBoxLayout newHorizontal
		add: #buttonObserver;
		add: #buttonPatches;
		add: #buttonTurtles;
		add:
			(SpBoxLayout newVertical
				add: #buttonAddTurtles;
				add: #buttonDeleteTurtles;
				yourself)
			withConstraints: [ :c | c width: 40 ];
		yourself
]

{ #category : #private }
SpSteloLibrary >> addTurtles [
	whenTurtlesAddedDo value
]

{ #category : #initialization }
SpSteloLibrary >> connectPresenters [
	buttonTurtles action: [ self selectTurtles ].
	buttonAddTurtles action: [ self addTurtles ].
	buttonDeleteTurtles action: [ self deleteTurtles ]
]

{ #category : #private }
SpSteloLibrary >> deleteTurtles [
	turtles size = 1
		ifTrue: [ self inform: 'Can''t delete all turtles' localized ]
		ifFalse: [ self deleteTurtlesMenu openWithSpecAt: self currentWorld cursorPoint ]
]

{ #category : #private }
SpSteloLibrary >> deleteTurtlesMenu [
	| menu |
	menu := self newMenu.
	turtles
		do: [ :each | 
			menu
				addItem: [ :item | 
					item
						name: each objName;
						action: [ self turtlesDeleted: each breedNo ] ] ].
	^ menu
]

{ #category : #initialization }
SpSteloLibrary >> initializePresenters [
	buttonObserver := self newButton.
	buttonPatches := self newButton.
	buttonTurtles := self newButton.
	buttonAddTurtles := self newButton.
	buttonDeleteTurtles := self newButton.
	buttonObserver label: 'Observer'.
	turtles := nil.
	buttonPatches
		label: 'Patches';
		icon: (ScratchTheme formAt: #clearGraphicsButtonPressed).
	buttonTurtles
		label: 'Turtles';
		icon: (ScratchTheme formAt: #clearTurtlesButtonPressed).
	buttonAddTurtles icon: (self iconNamed: #add).
	buttonDeleteTurtles icon: (self iconNamed: #delete).
	self selectButton: 'Observer'.
	self focusOrder
		add: buttonObserver;
		add: buttonPatches;
		add: buttonTurtles;
		add: buttonAddTurtles;
		add: buttonDeleteTurtles
]

{ #category : #accessing }
SpSteloLibrary >> observerAction: aBlock [
	buttonObserver
		action: [ self selectButton: buttonObserver label asString.
			aBlock cull: SBreedId observerBreedNo ]
]

{ #category : #accessing }
SpSteloLibrary >> patchesAction: aBlock [
	buttonPatches
		action: [ self selectButton: buttonPatches label asString.
			aBlock cull: SBreedId patchesBreedNo ]
]

{ #category : #accessing }
SpSteloLibrary >> selectButton: aString [
	buttonObserver state: aString = buttonObserver label asString.
	buttonPatches state: aString = buttonPatches label asString.
	buttonTurtles state: (aString beginsWith: buttonTurtles label asString)
]

{ #category : #private }
SpSteloLibrary >> selectTurtles [
	turtles size = 1
		ifTrue: [ self turtlesSelected: turtles first breedNo ]
		ifFalse: [ self selectTurtlesMenu openWithSpecAt: self currentWorld cursorPoint ]
]

{ #category : #private }
SpSteloLibrary >> selectTurtlesMenu [
	| menu |
	menu := self newMenu.
	turtles
		do: [ :each | 
			menu
				addItem: [ :item | 
					item
						name: each objName;
						action: [ self turtlesSelected: each breedNo ] ] ].
	^ menu
]

{ #category : #accessing }
SpSteloLibrary >> thumbnail: aForm [
	buttonObserver icon: aForm
]

{ #category : #accessing }
SpSteloLibrary >> turtles [
	^ turtles
]

{ #category : #accessing }
SpSteloLibrary >> turtles: aCollection [
	turtles := aCollection
]

{ #category : #private }
SpSteloLibrary >> turtlesDeleted: anInteger [
	whenTurtlesDeletedDo cull: anInteger
]

{ #category : #private }
SpSteloLibrary >> turtlesSelected: anInteger [
	self selectButton: buttonTurtles label asString.
	whenTurtlesSelectedDo cull: anInteger
]

{ #category : #accessing }
SpSteloLibrary >> whenTurtlesAddedDo: aBlock [
	whenTurtlesAddedDo := aBlock
]

{ #category : #accessing }
SpSteloLibrary >> whenTurtlesDeletedDo: aBlock [
	whenTurtlesDeletedDo := aBlock
]

{ #category : #accessing }
SpSteloLibrary >> whenTurtlesSelectedDo: aBlock [
	whenTurtlesSelectedDo := aBlock
]
