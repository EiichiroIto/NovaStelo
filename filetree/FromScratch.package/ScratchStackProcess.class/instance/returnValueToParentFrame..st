private
returnValueToParentFrame: anObject
	"Append the given object to the argument list of my parent frame."

	| f |
	stackFrame ifNil: [ ^ self ].
	f := stackFrame parentFrame.
	[ f notNil and: [ f shouldUnlight ] ]
		whileTrue: [ f := f parentFrame ].
	f ifNotNil: [ f addArgument: anObject ]