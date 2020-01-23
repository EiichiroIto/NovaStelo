private
getAllVariable: vno breed: bno
	| type |
	bno = SBreedId observerBreedNo ifTrue: [ ^ nil ].
	type := plugin getType: vno breed: bno.
	"type = SteloLibCall word
		ifTrue: [ ^ self getWordAll: vno breed: bno ]."
	type = SteloLibCall float
		ifTrue: [ ^ self getFloatAll: vno breed: bno ].
	type = SteloLibCall byte
		ifTrue: [ ^ self getByteAll: vno breed: bno ].
	^ nil