Extension { #name : 'AlignmentMorph' }

{ #category : '*FromScratch' }
AlignmentMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		orientation
		centering
		hResizing
		vResizing
		inset
	) from: anObjStream.
]

{ #category : '*FromScratch' }
AlignmentMorph >> rootForGrabOf: aMorph [

	| root |
	self dragNDropEnabled ifFalse: [^ super rootForGrabOf: aMorph].
	root := aMorph.
	[root == self] whileFalse:
		[root owner = self ifTrue: [^ root].
		root := root owner].
	^ super rootForGrabOf: aMorph
]

{ #category : '*FromScratch' }
AlignmentMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		orientation
		centering
		hResizing
		vResizing
		inset
	) on: anObjStream.

]
