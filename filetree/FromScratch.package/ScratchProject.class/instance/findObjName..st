accessing
findObjName: aString
	^ self scripts detect: [ :each | each objName = aString ]