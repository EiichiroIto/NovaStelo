private
setByteAll: vno breed: bno from: aByteArray
	| ext |
	ext := FFIExternalArray externalNewType: 'byte' size: aByteArray size.
	[ aByteArray withIndexDo: [ :each :index | ext at: index put: each ].
	plugin
		setByteAll: vno
		breed: bno
		extArray: ext
		size: aByteArray size ]
		ensure: [ ext free ]