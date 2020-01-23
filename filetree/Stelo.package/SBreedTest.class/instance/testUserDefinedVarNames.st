tests-variables
testUserDefinedVarNames
	| ts ps l |
	ts := STurtles new.
	ts addVariable: 'a'.
	l := ts userDefinedVarNames.
	self assertCollection: l asArray equals: #('a').
	ts addVariable: 'b'.
	l := ts userDefinedVarNames.
	self assertCollection: l asArray equals: #('a' 'b').
	ps := SPatches new.
	ps addVariable: 'a'.
	l := ps userDefinedVarNames.
	self assertCollection: l asArray equals: #('a').
	ps addVariable: 'b'.
	l := ps userDefinedVarNames.
	self assertCollection: l asArray equals: #('a' 'b').