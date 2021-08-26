Extension { #name : #BorderedMorph }

{ #category : #'*FromScratch' }
BorderedMorph >> fieldsVersion [
	^ 1
]

{ #category : #'*FromScratch' }
BorderedMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		borderWidth
		borderColor
	) from: anObjStream.

]

{ #category : #'*FromScratch' }
BorderedMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		borderWidth
		borderColor
	) on: anObjStream.

]
