accessing
plot: anInteger color: color
	| c |
	c := SColorList colorAt: color.
	plotList add: (ScratchPlot channel: anInteger color: c)