Class {
	#name : 'ColorList',
	#superclass : 'Object',
	#instVars : [
		'colors'
	],
	#classVars : [
		'DefaultList'
	],
	#category : 'Microworld-Core',
	#package : 'Microworld',
	#tag : 'Core'
}

{ #category : 'constants' }
ColorList class >> black [
	^ 0
]

{ #category : 'constants' }
ColorList class >> blue [
	^ 105
]

{ #category : 'constants' }
ColorList class >> brown [
	^ 35
]

{ #category : 'accessing' }
ColorList class >> clear [
	"SColorList clear."

	DefaultList := nil.
]

{ #category : 'accessing' }
ColorList class >> colorAt: anInteger [

	^ self default colorAt: anInteger
]

{ #category : 'accessing' }
ColorList class >> colorNames [
	^ #(black gray white red orange brown yellow green lime turquoise cyan sky blue purple magenta pink)
]

{ #category : 'accessing' }
ColorList class >> colorOf: aSymbol [
	^ self perform: aSymbol
]

{ #category : 'private' }
ColorList class >> colorOf: baseColor lightness: anInteger [
	^ Color h: baseColor hue s: baseColor saturation l: (self lightness at: anInteger + 6)
]

{ #category : 'private' }
ColorList class >> colors [
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
]

{ #category : 'constants' }
ColorList class >> cyan [
	^ 85
]

{ #category : 'accessing' }
ColorList class >> default [
	"SColorList default."

	DefaultList ifNil: [ DefaultList := self new ].
	^ DefaultList
]

{ #category : 'constants' }
ColorList class >> gray [
	^ 5
]

{ #category : 'constants' }
ColorList class >> green [
	^ 55
]

{ #category : 'private' }
ColorList class >> lightness [
	^ #(0.25 0.3 0.35 0.4 0.45 0.5 0.6 0.7 0.8 0.9)
]

{ #category : 'constants' }
ColorList class >> lime [
	^ 65
]

{ #category : 'constants' }
ColorList class >> magenta [
	^ 125
]

{ #category : 'constants' }
ColorList class >> orange [
	^ 25
]

{ #category : 'constants' }
ColorList class >> pink [
	^ 135
]

{ #category : 'constants' }
ColorList class >> purple [
	^ 115
]

{ #category : 'constants' }
ColorList class >> red [
	^ 15
]

{ #category : 'accessing' }
ColorList class >> scaleGrayscale: v from: aNumber1 to: aNumber2 [
	aNumber1 = aNumber2
		ifTrue: [ ^ 0 ].
	(aNumber1 < aNumber2 and: [ v < aNumber1 ])
		ifTrue: [ ^ 0 ].
	(aNumber1 < aNumber2 and: [ v > aNumber2 ])
		ifTrue: [ ^ 255 ].
	(aNumber1 > aNumber2 and: [ v > aNumber1 ])
		ifTrue: [ ^ 0 ].
	(aNumber1 > aNumber2 and: [ v < aNumber2 ])
		ifTrue: [ ^ 255 ].
	^ (0 interpolateTo: 255 at: (v - aNumber1) / (aNumber2 - aNumber1))
		truncated
]

{ #category : 'accessing' }
ColorList class >> scaleValue: v color: anInteger from: aNumber1 to: aNumber2 [
	anInteger < 5
		ifTrue: [ ^ self scaleGrayscale: v from: aNumber1 to: aNumber2 ].
	aNumber1 = aNumber2
		ifTrue: [ ^ self black ].
	(aNumber1 < aNumber2 and: [ v < aNumber1 ])
		ifTrue: [ ^ self black ].
	(aNumber1 < aNumber2 and: [ v > aNumber2 ])
		ifTrue: [ ^ self white ].
	(aNumber1 > aNumber2 and: [ v > aNumber1 ])
		ifTrue: [ ^ self black ].
	(aNumber1 > aNumber2 and: [ v < aNumber2 ])
		ifTrue: [ ^ self white ].
	^ (anInteger - 5
		interpolateTo: anInteger + 4
		at: (v - aNumber1) / (aNumber2 - aNumber1)) truncated
]

{ #category : 'constants' }
ColorList class >> sky [
	^ 95
]

{ #category : 'constants' }
ColorList class >> turquoise [
	^ 75
]

{ #category : 'constants' }
ColorList class >> white [
	^ 9
]

{ #category : 'constants' }
ColorList class >> yellow [
	^ 45
]

{ #category : 'accessing' }
ColorList >> colorAt: anInteger [

	| index |
	index := self normalize: anInteger.
	^ colors at: index + 1
]

{ #category : 'private' }
ColorList >> generateSource [
	| w |
	w := WriteStream on: ''.
	colors
		withIndexDo: [ :each :index | 
			w
				nextPutAll: 'color[';
				nextPutAll: (index - 1) asString;
				nextPutAll: '] = RGB(';
				nextPutAll: (each red * 255) truncated asString;
				nextPutAll: ',';
				nextPutAll: (each green * 255) truncated asString;
				nextPutAll: ',';
				nextPutAll: (each blue * 255) truncated asString;
				nextPutAll: ');';
				nextPutAll: String lf ].
	^ w contents
]

{ #category : 'initialization' }
ColorList >> initialize [
	colors := self class colors.
]

{ #category : 'accessing' }
ColorList >> nearestColor: aColor [

	| list min minIndex |
	list := colors collect: [ :each | each diff: aColor ].
	min := 1.0.
	minIndex := nil.
	list withIndexDo: [ :each :index | 
		each < min ifTrue: [ 
			min := each.
			minIndex := index ] ].
	^ minIndex - 1
]

{ #category : 'accessing' }
ColorList >> normalize: aNumber [
	^ aNumber floor \\ colors size
]

{ #category : 'accessing' }
ColorList >> random [
	^ colors size atRandom - 2 + 1
]

{ #category : 'accessing' }
ColorList >> size [
	^ colors size
]
