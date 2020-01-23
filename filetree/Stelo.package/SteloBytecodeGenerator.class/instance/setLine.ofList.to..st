list ops
setLine: anInteger ofList: vno to: aNumber
	self appendValue: anInteger.
	self appendValue: aNumber.
	self appendValue: vno.
	self appendSymbol: #setLineOfListTo.