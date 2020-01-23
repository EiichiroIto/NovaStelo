initialization
initialize

	super initialize.
	self cornerStyle: #square.
	color := Color transparent.
	borderWidth := 0.
	isOn := false.
	toggleButtonMode := false.
	toggleMode := true.
	justification := #center.
	hOffset := 0.
	vOffset := 5.
	padding := 8@8.

	label2 := StringMorph new.
	labelColorOff := Color r: (78/255) g: (82/255) b: (82/255).
	labelColorOn := Color black.
	labelColorOver := labelColorOff.
