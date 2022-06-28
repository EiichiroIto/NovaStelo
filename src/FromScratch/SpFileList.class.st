Class {
	#name : #SpFileList,
	#superclass : #SpPresenter,
	#instVars : [
		'directory',
		'pattern',
		'buttonParent',
		'buttonNew',
		'itemSelectedBlock',
		'listHierarchy',
		'listEntries'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpFileList class >> defaultLayout [
	^ SpBoxLayout newVertical
		spacing: 4;
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #listHierarchy;
				add: #buttonParent withConstraints: [ :constraints | constraints expand: false ];
				add: #buttonNew withConstraints: [ :constraints | constraints expand: false ];
				yourself)
			withConstraints: [ :constraints | constraints expand: false ];
		add: #listEntries;
		yourself
]

{ #category : #private }
SpFileList >> changeParentDirectory [
	directory isRoot ifTrue: [ ^ self ].
	self directory: directory parent
]

{ #category : #initialization }
SpFileList >> connectPresenters [
	listEntries
		display: [ :m | self showEntry: m ];
		whenActivatedDo: [ :selection | self entriesChanged: selection ].
	listHierarchy
		whenSelectedItemChangedDo: [ :selection | self currentChanged: selection ].
	buttonParent action: [ self changeParentDirectory ].
	buttonNew action: [ self newFolder ]
]

{ #category : #private }
SpFileList >> currentChanged: aString [
	| dir |
	listHierarchy selectedIndex = 0
		ifTrue: [ ^ self ].
	dir := directory.
	directory path segments size - listHierarchy selectedIndex
		timesRepeat: [ dir := dir parent ].
	self directory: dir
]

{ #category : #accessing }
SpFileList >> directory [
	^ directory
]

{ #category : #accessing }
SpFileList >> directory: aFileReference [
	directory := aFileReference.
	self listHierarchyContents: self directoryHierarchy.
	self listEntriesContents: self getEntries
]

{ #category : #private }
SpFileList >> directoryHierarchy [
	^ directory path segments
		withIndexCollect: [ :each :index | (String new: index withAll: Character space) , each ]
]

{ #category : #private }
SpFileList >> entriesChanged: aSelectionMode [
	| dir |
	dir := aSelectionMode selectedItem.
	dir isDirectory
		ifFalse: [ ^ self ].
	self directory: dir asFileReference
]

{ #category : #private }
SpFileList >> getEntries [
	| dirs files stream |
	dirs := directory directories asOrderedCollection.
	dirs
		sort: [ :a :b | a basename asLowercase < b basename asLowercase ].
	stream := WriteStream on: OrderedCollection new.
	(pattern isNil or: [ pattern isEmpty ])
		ifTrue: [ stream nextPutAll: directory files ]
		ifFalse: [ stream nextPutAll: (directory filesMatching: pattern) ].
	files := stream contents.
	files
		sort: [ :a :b | a basename asLowercase < b basename asLowercase ].
	^ (dirs , files) reject: [ :each | each basename beginsWith: '.' ]
]

{ #category : #initialization }
SpFileList >> initializePresenters [
	listHierarchy := self newDropList
		startWithoutSelection.
	listEntries := self newList
		beSingleSelection;
		activateOnDoubleClick.
	buttonParent := self newButton
		icon: (self iconNamed: #up).
	buttonNew := self newButton
		icon: (self iconNamed: #add).
	self directory: FileSystem workingDirectory.
	self focusOrder
		add: listHierarchy;
		add: buttonParent;
		add: buttonNew;
		add: listEntries
]

{ #category : #private }
SpFileList >> listEntriesContents: aCollection [
	listEntries
		unselectAll;
		items: #();
		items: aCollection
]

{ #category : #private }
SpFileList >> listHierarchyContents: aCollection [
	listHierarchy
		selectIndex: 0;
		items: aCollection;
		selectIndex: aCollection size
]

{ #category : #private }
SpFileList >> newFolder [

	| name |
	name := SpScratchApp request: 'New folder name:' localized.
	(name isNil or: [ name isEmpty ]) ifTrue: [ ^ self ].
	[ (directory / name) createDirectory ]
		on: Error
		do: [ :err :rcvr | 
			^ SpScratchApp alert: 'Could not create folder!' localized ].
	self directory: directory / name
]

{ #category : #accessing }
SpFileList >> pattern [
	^ pattern
]

{ #category : #accessing }
SpFileList >> pattern: aCollection [
	pattern := aCollection
]

{ #category : #accessing }
SpFileList >> selectedFile [
	| list |
	list := listEntries selectedItems.
	list isEmpty ifTrue: [ ^ nil ].
	^ list first
]

{ #category : #private }
SpFileList >> showEntry: aFileReference [
	| base |
	base := aFileReference basename.
	^ aFileReference isDirectory
		ifTrue: [ '<' , base , '>' ]
		ifFalse: [ base ]
]

{ #category : #accessing }
SpFileList >> whenFileSelectedBlock: aBlock [
	itemSelectedBlock := aBlock.
	itemSelectedBlock
		ifNotNil: [ listEntries whenSelectionChangedDo: itemSelectedBlock ]
]
