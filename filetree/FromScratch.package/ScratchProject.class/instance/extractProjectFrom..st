file read/write
extractProjectFrom: aByteArray
	| s version proj obj |
	obj := self newObjStream.
	s := ReadStream on: aByteArray.
	version := obj class fileVersion: self class from: s.
	version = self class appVersion
		ifFalse: [ ^ self inform: 'Invalid app version!' localized ].
	s skip: s uint32.
	proj := obj readObjFrom: s showProgress: true.
	proj isProject
		ifFalse: [ ^ self error: 'Invalid project format:' localized , proj class asString ].
	proj scripts
		do: [ :m | 
			m
				setupBlockDef;
				convertStacksToTuples;
				convertTuplesToStacks;
				project: proj ].
	^ proj