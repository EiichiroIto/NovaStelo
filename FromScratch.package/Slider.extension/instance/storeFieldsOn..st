*FromScratch
storeFieldsOn: anObjStream

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
