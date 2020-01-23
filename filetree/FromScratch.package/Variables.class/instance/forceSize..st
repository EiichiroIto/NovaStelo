accessing
forceSize: anInteger
	vars
		withIndexDo: [ :each :index | each ifNotNil: [ each forceSize: anInteger ] ]