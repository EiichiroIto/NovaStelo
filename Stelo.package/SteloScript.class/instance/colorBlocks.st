block specs
colorBlocks
	^ #(
		'color'
			('color'					r	getColor)
			('set color to %c'			- setColor: 15)
			('scale %v color %c from %n to %n'  - #scaleValue:color:from:to: '' 15 0 100 )
			-
			('random'				r	colorRandom)
			('black'				r	colorBlack)
			('gray'				r	colorGray)
			('white'				r	colorWhite)
			('red'					r	colorRed)
			('orange'			r	colorOrange)
			('brown'				r	colorBrown)
			('yellow'			r	colorYellow)
			('green'				r	colorGreen)
			('lime'				r	colorLime)
			('turquoise'		r	colorTurquoise)
			('cyan'				r	colorCyan)
			('sky'					r	colorSky)
			('blue'				r	colorBlue)
			('purple'			r	colorPurple)
			('magenta'			r	colorMagenta)
			('pink'				r	colorPink)
	)