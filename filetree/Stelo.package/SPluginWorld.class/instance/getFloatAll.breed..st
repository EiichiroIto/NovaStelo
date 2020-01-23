private
getFloatAll: vno breed: bno
	| size ptr ext arr |
	size := self sizeOf: bno.
	ptr := plugin getFloatAll: vno breed: bno.
	ptr isNull
		ifTrue: [ ^ nil ].
	ext := FFIExternalArray
		fromHandle: ptr getHandle
		type: ExternalType float.
	[ arr := FloatArray new: size withAll: 0.0.
	1 to: size do: [ :each | arr at: each put: (ext at: each) ] ]
		ensure: [ ptr autoRelease ].
	^ arr