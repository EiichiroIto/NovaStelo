variable ops
changeVar: id by: aNumber
	self appendValue: id.
	self appendSymbol: #dup.
	self appendSymbol: #getVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setVarTo.