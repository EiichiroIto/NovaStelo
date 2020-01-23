initialization
useTypeinFrame

	frame := ImageFrameMorph new initFromForm: (ScratchTheme formAt: #typein).
	insetX := 2.
	heightPadding := 5.
	borderWidth := 2.
	self font: stringMorph font.
