accessing
var: vno breed: bno at: tno put: value
	| t |
	t := plugin getType: vno breed: bno.
	t = SteloLibCall float
		ifTrue: [ ^ plugin
				setFloat: vno
				breed: bno
				id: tno
				value: value ].
	t = SteloLibCall byte
		ifTrue: [ ^ plugin
				setByte: vno
				breed: bno
				id: tno
				value: value ].
	"t = SteloLibCall word
		ifTrue: [ ^ plugin
				setWord: vno
				breed: bno
				id: tno
				value: value ]."
	t = SteloLibCall computedFloat
		ifTrue: [ self error ].
	t = SteloLibCall none
		ifTrue: [ self error ]