control ops
doRepeatBegin: num
	| label1 label2 |
	label1 := labelId newNo.
	label2 := labelId newNo.
	self appendValue: num.
	self appendLabel: label1.
	self appendSymbol: #dup.
	self appendValue: 0.
	self appendSymbol: #equal.
	self appendSymbol: #jumpIfTrue withJump: label2.
	^ 	Array with: label1 with: label2