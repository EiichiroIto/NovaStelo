test
testClassName
	| l |
	l := LazyArray basicNew.
	self assert: l className isNil.
	l className: #FloatArray.
	self assert: l className equals: #FloatArray