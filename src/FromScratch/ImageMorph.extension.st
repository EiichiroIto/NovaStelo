Extension { #name : 'ImageMorph' }

{ #category : '*FromScratch' }
ImageMorph >> fieldsVersion [
	^ 1
]

{ #category : '*FromScratch' }
ImageMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		form
		"transparency"
	) from: anObjStream.

]

{ #category : '*FromScratch' }
ImageMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		form
		"transparency"
	) on: anObjStream.

]
