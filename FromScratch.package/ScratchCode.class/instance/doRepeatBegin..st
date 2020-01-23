control ops
doRepeatBegin: aMorph
	| num labels |
	num := aMorph blockArgs first argString: parser.
	labels := bcGenerator doRepeatBegin: num.
	aMorph labelId: labels.