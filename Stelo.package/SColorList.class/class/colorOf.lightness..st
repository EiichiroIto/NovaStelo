private
colorOf: baseColor lightness: anInteger
	^ Color h: baseColor hue s: baseColor saturation l: (self lightness at: anInteger + 6)