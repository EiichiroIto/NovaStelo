private
setFloatAll: vno breed: bno from: aFloatArray
	| ext |
	ext := FFIExternalArray externalNewType: 'float' size: aFloatArray size.
	aFloatArray withIndexDo: [ :each :index | ext at: index put: each ].
	plugin setFloatAll: vno breed: bno extArray: ext size: aFloatArray size.