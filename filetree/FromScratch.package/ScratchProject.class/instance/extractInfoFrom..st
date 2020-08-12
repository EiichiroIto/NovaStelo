file read/write
extractInfoFrom: aByteArray
	| s version obj |
	obj := self newObjStream.
	s := ReadStream on: aByteArray.
	version := obj class fileVersion: self class from: s.
	version = self class appVersion
		ifFalse: [ ^ self inform: 'Invalid app version!' localized ].
	s skip: 4.
	info := obj readObjFrom: s showProgress: false