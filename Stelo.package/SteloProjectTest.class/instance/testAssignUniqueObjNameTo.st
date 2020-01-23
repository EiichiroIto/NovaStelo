test
testAssignUniqueObjNameTo
	| proj s1 s2 s3 s |
	proj := self newProject.
	s1 := self newTurtleScript objName: 'a'.
	proj addScript: s1.
	s2 := self newTurtleScript objName: 'b'.
	proj addScript: s2.
	s := self newTurtleScript.
	s objName: 'abc'.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: 'abc'.
	s := self newTurtleScript.
	s breed: (STurtles new breedNo: 3).
	self assert: s objName isNil.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: s defaultObjName.
	s3 := self newTurtleScript objName: s defaultObjName.
	proj addScript: s3.
	s := self newTurtleScript.
	s breed: (STurtles new breedNo: 3).
	self assert: s objName isNil.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: s defaultObjName , 'x'