file read/write
extractProjectFrom: aByteArray
	| s version proj |
	s := ReadStream on: aByteArray.
	version := ObjStream fileVersion: self class from: s.
	version = 1
		ifFalse: [ ^ self error: 'Invalid version' ].
	s skip: s uint32.
	proj := self newObjStream readObjFrom: s showProgress: true.
	proj isProject
		ifFalse: [ ^ self error: 'Invalid project format :' , proj class asString ].
	proj scripts
		do: [ :m | 
			m
				setupBlockDef;
				convertStacksToTuples;
				convertTuplesToStacks;
				project: proj ].
	^ proj