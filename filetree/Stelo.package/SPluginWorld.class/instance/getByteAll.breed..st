private
getByteAll: vno breed: bno
	| size ptr |
	size := self sizeOf: bno.
	ptr := plugin getByteAll: vno breed: bno.
	ptr isNull
		ifTrue: [ ^ nil ].
	^ [ ptr copyFrom: 1 to: size ]
		ensure: [ ptr autoRelease ]