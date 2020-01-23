accessing
parse: aCollection
	| in |
	in := ReadStream on: aCollection.
	^ self parseItem: in