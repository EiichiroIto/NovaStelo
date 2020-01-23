instance creation
channel: anInteger colorAt: color
	^ SteloPlotColor new
		channel: anInteger;
		color: (SColorList colorAt: color) ;
		yourself