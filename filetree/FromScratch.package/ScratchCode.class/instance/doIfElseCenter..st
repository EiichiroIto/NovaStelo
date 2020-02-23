control ops
doIfElseCenter: aMorph
	| orgId newId |
	orgId := aMorph labelId.
	newId := generator doIfElse: orgId.
	aMorph labelId: newId.