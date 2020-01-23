fixed format-reading
getBytes: anObject id: classID
	| byteCount result |
	byteCount := stream uint32.
	result := stream next: byteCount.
	classID = 9
		ifTrue: [ ^ result asString ].
	classID = 10
		ifTrue: [ ^ result asString asSymbol ].
	classID = 14
		ifTrue: [ ^ self convertFromUTF8: result ].
	classID = 17
		ifTrue: [ ^ result asWideString ].
	^ result.