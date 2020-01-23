microworld
scaleValue: v color: anInteger from: aNumber1 to: aNumber2
	(aNumber1 < aNumber2 and: [ v < aNumber1 ])
		ifTrue: [ ^ SColorList black ].
	(aNumber1 < aNumber2 and: [ v > aNumber2 ])
		ifTrue: [ ^ SColorList white ].
	(aNumber1 > aNumber2 and: [ v > aNumber1 ])
		ifTrue: [ ^ SColorList black ].
	(aNumber1 > aNumber2 and: [ v < aNumber2 ])
		ifTrue: [ ^ SColorList white ].
	^ (anInteger - 5 interpolateTo: anInteger + 4 at: (v - aNumber1) / (aNumber2 - aNumber1))
		truncated