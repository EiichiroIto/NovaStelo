file read/write
extractInfoFrom: aByteArray
	| s version |
	s := ReadStream on: aByteArray.
	version := ObjStream fileVersion: self class from: s.
	version = 1
		ifFalse: [ ^ self error: 'Invalid version' ].
	s skip: 4.
	info := self newObjStream readObjFrom: s showProgress: false