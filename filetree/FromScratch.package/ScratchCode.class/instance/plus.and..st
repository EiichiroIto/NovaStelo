arithmetic ops
plus: x and: y
	^ generator plus: [ x argString: parser ] and: [ y argString: parser ]