control ops
doIfElseCenter: aMorph
	| orgId newId |
	orgId := aMorph labelId.
	newId := bcGenerator doIfElse: orgId.
	aMorph labelId: newId.