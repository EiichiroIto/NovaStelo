accessing
deleteBreed: aBreed
	| bno |
	bno := aBreed breedNo.
	(breeds at: bno) ifNil: [ self error ].
	breeds at: bno put: nil