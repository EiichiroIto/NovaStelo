menu actions
showBreedNo: bno at: anInteger
	| dialog |
	dialog := self instantiate: SpSteloBreedView.
	dialog
		title: self target objName , ' Variables';
		getValuesBlock: [ self sworld varsBreed: bno at: anInteger ];
		whenDeletedDo: [ self sworld kill: bno at: anInteger ].
	bno < SBreedId turtleBreedNo
		ifTrue: [ dialog openDialogWithSpec: #noDeleteButtonSpec ]
		ifFalse: [ dialog openDialogWithSpec ]