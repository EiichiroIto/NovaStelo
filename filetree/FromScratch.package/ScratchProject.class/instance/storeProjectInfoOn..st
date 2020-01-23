file read/write
storeProjectInfoOn: aBinaryStream
	| s |
	s := WriteStream on: (ByteArray new: 100000).
	self newObjStream storeObj: info on: s.
	aBinaryStream uint32: s size.
	aBinaryStream nextPutAll: s contents