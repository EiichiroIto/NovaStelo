test
testArrayClass
	| l |
	l := LazyArray basicNew.
	l className: #FloatArray.
	self assert: l arrayClass equals: FloatArray.
	l := LazyArray basicNew.
	l className: #ByteArray.
	self assert: l arrayClass equals: ByteArray.