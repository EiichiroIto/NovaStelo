test
testUserDefinedVarNoAndNames
	| ts ps l |
	ts := STurtles new.
	ts addVariable: 'a'.
	l := ts userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((6 'a')).
	ts addVariable: 'b'.
	l := ts userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((6 'a') (7 'b')).
	ps := SPatches new.
	ps addVariable: 'a'.
	l := ps userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((5 'a')).
	ps addVariable: 'b'.
	l := ps userDefinedVarNoAndNames.
	self assertCollection: l asArray equals: #((5 'a') (6 'b')).