accessing
blockDef
	^ blockDef ifNil: [ self setupBlockDef ]