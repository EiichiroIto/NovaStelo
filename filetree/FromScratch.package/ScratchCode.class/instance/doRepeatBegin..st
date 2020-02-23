control ops
doRepeatBegin: aMorph
	| num labels |
	num := aMorph blockArgs first argString: parser.
	labels := generator doRepeatBegin: num.
	aMorph labelId: labels.