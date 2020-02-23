private
equalityTest: inObj
	"For testing. Serialize and deserialize the given object and compare the result for equality with the original object."

	| outObj |
	outObj := self serializeAndDeserialize: inObj.
	outObj class == inObj class
		ifFalse: [ self error: 'output class is not equal to input class' ].
	outObj = inObj
		ifFalse: [ self error: 'output is not equal to input' ]