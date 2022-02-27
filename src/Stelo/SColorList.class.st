Class {
	#name : #SColorList,
	#superclass : #Object,
	#instVars : [
		'colors'
	],
	#classVars : [
		'DefaultList'
	],
	#category : #'Stelo-Model'
}

{ #category : #constants }
SColorList class >> black [
	^ 0
]

{ #category : #constants }
SColorList class >> blue [
	^ 105
]

{ #category : #constants }
SColorList class >> brown [
	^ 35
]

{ #category : #accessing }
SColorList class >> clear [
	"SColorList clear."

	DefaultList := nil.
]

{ #category : #accessing }
SColorList class >> colorNames [
	^ #(black gray white red orange brown yellow green lime turquoise cyan sky blue purple magenta pink)
]

{ #category : #accessing }
SColorList class >> colorOf: aSymbol [
	^ self perform: aSymbol
]

{ #category : #private }
SColorList class >> colorOf: baseColor lightness: anInteger [
	^ Color h: baseColor hue s: baseColor saturation l: (self lightness at: anInteger + 6)
]

{ #category : #private }
SColorList class >> colors [
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

{ #category : #constants }
SColorList class >> cyan [
	^ 85
]

{ #category : #accessing }
SColorList class >> default [
	"SColorList default."

	DefaultList ifNil: [ DefaultList := self new ].
	^ DefaultList
]

{ #category : #constants }
SColorList class >> gray [
	^ 5
]

{ #category : #constants }
SColorList class >> green [
	^ 55
]

{ #category : #private }
SColorList class >> lightness [
	^ #(0.25 0.3 0.35 0.4 0.45 0.5 0.6 0.7 0.8 0.9)
]

{ #category : #constants }
SColorList class >> lime [
	^ 65
]

{ #category : #constants }
SColorList class >> magenta [
	^ 125
]

{ #category : #constants }
SColorList class >> orange [
	^ 25
]

{ #category : #constants }
SColorList class >> pink [
	^ 135
]

{ #category : #constants }
SColorList class >> purple [
	^ 115
]

{ #category : #constants }
SColorList class >> red [
	^ 15
]

{ #category : #accessing }
SColorList class >> scaleValue: v color: anInteger from: aNumber1 to: aNumber2 [
	(aNumber1 < aNumber2 and: [ v < aNumber1 ])
		ifTrue: [ ^ self black ].
	(aNumber1 < aNumber2 and: [ v > aNumber2 ])
		ifTrue: [ ^ self white ].
	(aNumber1 > aNumber2 and: [ v > aNumber1 ])
		ifTrue: [ ^ self black ].
	(aNumber1 > aNumber2 and: [ v < aNumber2 ])
		ifTrue: [ ^ self white ].
	^ (anInteger - 5 interpolateTo: anInteger + 4 at: (v - aNumber1) / (aNumber2 - aNumber1))
		truncated
]

{ #category : #constants }
SColorList class >> sky [
	^ 95
]

{ #category : #constants }
SColorList class >> turquoise [
	^ 75
]

{ #category : #constants }
SColorList class >> white [
	^ 9
]

{ #category : #constants }
SColorList class >> yellow [
	^ 45
]

{ #category : #private }
SColorList >> generateSource [
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

{ #category : #initialization }
SColorList >> initialize [
	colors := self class colors.
]

{ #category : #accessing }
SColorList >> normalize: aNumber [
	^ aNumber floor \\ colors size
]

{ #category : #accessing }
SColorList >> random [
	^ colors size atRandom - 2 + 1
]

{ #category : #accessing }
SColorList >> realColorAt: anInteger [
	| index |
	index := self normalize: anInteger.
	^ colors at: index + 1
]

{ #category : #accessing }
SColorList >> size [
	^ colors size
]
