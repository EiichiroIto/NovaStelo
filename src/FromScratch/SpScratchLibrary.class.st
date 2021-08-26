Class {
	#name : #SpScratchLibrary,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonMain',
		'buttonSelect',
		'buttonAdd',
		'buttonDelete',
		'buttonOther'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpScratchLibrary class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #buttonMain;
		add: #buttonOther;
		add: #buttonAdd withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonSelect withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonDelete withConstraints: [ :c | c width: self buttonWidth ];
		yourself
]

{ #category : #private }
SpScratchLibrary >> defaultMainButtonName [
	^ 'main'
]

{ #category : #private }
SpScratchLibrary >> defaultOtherButtonName [
	^ '(none)'
]

{ #category : #initialization }
SpScratchLibrary >> initializePresenters [
	buttonMain := self newButton
		label: self defaultMainButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonOther := self newButton
		label: self defaultOtherButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonSelect := self newButton
		icon: (self iconNamed: #book);
		yourself.
	buttonAdd := self newButton
		icon: (self iconNamed: #add);
		yourself.
	buttonDelete := self newButton
		icon: (self iconNamed: #delete);
		yourself.
	self focusOrder
		add: buttonMain;
		add: buttonSelect;
		add: buttonAdd;
		add: buttonDelete
]

{ #category : #accessing }
SpScratchLibrary >> mainLabel [
	^ buttonMain label asString
]

{ #category : #accessing }
SpScratchLibrary >> otherLabel [
	^ buttonOther label asString
]

{ #category : #accessing }
SpScratchLibrary >> otherLabel: aString [
	buttonOther label: aString
]

{ #category : #accessing }
SpScratchLibrary >> reset [
	self otherLabel: self defaultOtherButtonName.
	self selectButton: self defaultMainButtonName
]

{ #category : #accessing }
SpScratchLibrary >> selectButton: aString [
	buttonMain state: (self mainLabel = aString).
	buttonOther state: (self otherLabel = aString)
]

{ #category : #accessing }
SpScratchLibrary >> whenAddButtonPressed: aBlock [
	buttonAdd action: aBlock
]

{ #category : #accessing }
SpScratchLibrary >> whenDeleteButtonPressed: aBlock [
	buttonDelete action: aBlock
]

{ #category : #accessing }
SpScratchLibrary >> whenMainButtonPressed: aBlock [
	buttonMain action: aBlock
]

{ #category : #accessing }
SpScratchLibrary >> whenOtherButtonPressed: aBlock [
	buttonOther action: [ aBlock cull: self otherLabel ]
]

{ #category : #accessing }
SpScratchLibrary >> whenSelectButtonPressed: aBlock [
	buttonSelect action: aBlock
]
