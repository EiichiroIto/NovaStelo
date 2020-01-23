private
getEntries
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