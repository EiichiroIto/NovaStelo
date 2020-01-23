accessing
var: vno breed: bno at: tno
	| t |
	t := plugin getType: vno breed: bno.
	t = SteloLibCall float
		ifTrue: [ ^ plugin getFloat: vno breed: bno id: tno ].
	t = SteloLibCall byte
		ifTrue: [ ^ plugin getByte: vno breed: bno id: tno ].
	"t = SteloLibCall word
		ifTrue: [ ^ plugin getWord: vno breed: bno id: tno ]."
	t = SteloLibCall computedFloat
		ifTrue: [ ^ plugin getFloat: vno breed: bno id: tno ].
	t = SteloLibCall none
		ifTrue: [ self error ]