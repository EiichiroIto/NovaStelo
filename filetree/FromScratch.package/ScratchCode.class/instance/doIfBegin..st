control ops
doIfBegin: aMorph
	| cond id |
	cond := aMorph blockArgs first argString: parser.
	id := generator doIfBegin: cond.
	aMorph labelId: id.