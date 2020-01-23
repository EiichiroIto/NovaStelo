Extension { #name : #Slider }

{ #category : #'*FromScratch' }
Slider >> initFieldsFrom: anObjStream version: classVersion [

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		slider
		value
		setValueSelector
		sliderShadow
		sliderColor
		descending
		model
	) from: anObjStream.

]

{ #category : #'*FromScratch' }
Slider >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		slider
		value
		setValueSelector
		sliderShadow
		sliderColor
		descending
		model
	) on: anObjStream.

]
