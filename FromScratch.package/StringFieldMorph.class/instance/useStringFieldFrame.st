initialization
useStringFieldFrame

	frame := ImageFrameMorph new initFromForm: (ScratchTheme formAt: #stringFieldFrame).
	insetX := 3.
	heightPadding := 9.
	borderWidth := 5.
	self font: stringMorph font.
