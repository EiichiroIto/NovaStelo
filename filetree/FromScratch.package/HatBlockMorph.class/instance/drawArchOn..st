drawing
drawArchOn: aCanvas 

	| archForm stretchX leftForm midForm rightForm y x |
	archForm := self hatTopForm.
	stretchX := archForm width - 22.
	leftForm := archForm copy: (0@0 corner: stretchX@archForm height).
	midForm := archForm copy: (stretchX@0 extent: 1@archForm height).
	rightForm := archForm copy: ((stretchX + 1)@0 corner: archForm extent).
	
	y := self top.
	x := self left.
	aCanvas paintImage: leftForm at: x@y.
	x := x + leftForm width.
	(self width - (leftForm width + rightForm width)) asInteger timesRepeat: [
		aCanvas paintImage: midForm at: x@y.
		x := x + 1].
	aCanvas paintImage: rightForm at: x@y.
