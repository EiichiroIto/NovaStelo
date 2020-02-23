file read/write
extractInfoFrom: aByteArray
	| s version |
	s := ReadStream on: aByteArray.
	version := ObjStream fileVersion: self class from: s.
	version = self class appVersion
		ifFalse: [ ^ self inform: 'Invalid version' ].
	s skip: 4.
	info := self newObjStream readObjFrom: s showProgress: false