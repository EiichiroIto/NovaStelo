initialization
initVertical: aBoolean

	aBoolean
		ifTrue: [
		 	self vFrameForm: (ScratchTheme formAt: #vScrollFrame)
				sliderForm: (ScratchTheme formAt: #vScrollSlider)]
		ifFalse: [
		 	self hFrameForm: (ScratchTheme formAt: #hScrollFrame)
				sliderForm: (ScratchTheme formAt: #hScrollSlider)].
