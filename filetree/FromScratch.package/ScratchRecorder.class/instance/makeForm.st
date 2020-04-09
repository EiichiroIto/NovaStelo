private
makeForm
	| form frame |
	form := model stageShotExtent: extent.
	form := form as8BitColorForm.
	frame := AnimatedImageFrame new
		delay: self defaultFrameDelay;
		form: form.
	^ frame