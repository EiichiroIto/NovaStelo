Extension { #name : 'SimpleButtonMorph' }

{ #category : '*FromScratch' }
SimpleButtonMorph >> fieldsVersion [
	^ 1
]

{ #category : '*FromScratch' }
SimpleButtonMorph >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		target
		actionSelector
		arguments
		actWhen
	) from: anObjStream.

]

{ #category : '*FromScratch' }
SimpleButtonMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		target
		actionSelector
		arguments
		actWhen
	) on: anObjStream.

]
