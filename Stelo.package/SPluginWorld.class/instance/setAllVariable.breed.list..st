private
setAllVariable: vno breed: bno list: list
	| type |
	list ifNil: [ ^ self ].
	type := plugin getType: vno breed: bno.
	"type = SteloLibCall word
		ifTrue: [ ^ self setWordAll: vno breed: bno from: list ]."
	type = SteloLibCall float
		ifTrue: [ ^ self setFloatAll: vno breed: bno from: list ].
	type = SteloLibCall byte
		ifTrue: [ ^ self setByteAll: vno breed: bno from: list ]