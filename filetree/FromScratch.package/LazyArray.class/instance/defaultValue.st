accessing
defaultValue
	^ defaultValue ifNil: [ self array defaultElement ]