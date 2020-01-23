private
colors
	| colors c |
	colors := Array new: 140.
	1 to: 10 do: [ :each | 
		c := Color h: Color black hue s: Color black saturation l: (each - 1) / 9.0.
		colors at: each put: c ].
	11 to: 20 do: [ :each | colors at: each put: (self colorOf: Color red lightness: each - self red - 1) ].
	21 to: 30 do:
		[ :each | colors at: each put: (self colorOf: Color orange lightness: each - self orange - 1) ].
	31 to: 40 do:
		[ :each | colors at: each put: (self colorOf: Color brown lightness: each - self brown - 1) ].
	41 to: 50 do:
		[ :each | colors at: each put: (self colorOf: Color yellow lightness: each - self yellow - 1) ].
	51 to: 60 do:
		[ :each | colors at: each put: (self colorOf: Color green lightness: each - self green - 1) ].
	61 to: 70 do: [ :each | 
		colors
			at: each
			put:
				(self
					colorOf:
						(Color
							r: 50
							g: 205
							b: 50
							range: 255)
					lightness: each - self lime - 1) ].
	71 to: 80 do: [ :each | 
		colors
			at: each
			put:
				(self
					colorOf:
						(Color
							r: 64
							g: 224
							b: 208
							range: 255)
					lightness: each - self turquoise - 1) ].
	81 to: 90 do:
		[ :each | colors at: each put: (self colorOf: Color cyan lightness: each - self cyan - 1) ].
	91 to: 100 do: [ :each | 
		colors
			at: each
			put:
				(self
					colorOf:
						(Color
							r: 178
							g: 255
							b: 255
							range: 255)
					lightness: each - self sky - 1) ].
	101 to: 110 do:
		[ :each | colors at: each put: (self colorOf: Color blue lightness: each - self blue - 1) ].
	111 to: 120 do:
		[ :each | colors at: each put: (self colorOf: Color purple lightness: each - self purple - 1) ].
	121 to: 130 do:
		[ :each | colors at: each put: (self colorOf: Color magenta lightness: each - self magenta - 1) ].
	131 to: 140 do:
		[ :each | colors at: each put: (self colorOf: Color pink lightness: each - self pink - 1) ].
	^ colors