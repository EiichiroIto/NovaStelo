other
printArgOn: aStream
	"Print this argument morph on the given stream."

	| v |
	self labelMorph ifNotNil: [
		v := self evaluate.
		(v isKindOf: String)
			ifTrue: [aStream nextPutAll: '"', v, '"']
			ifFalse: [aStream nextPutAll: v asString]].

