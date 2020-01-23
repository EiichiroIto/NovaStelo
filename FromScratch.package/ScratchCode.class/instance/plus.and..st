arithmetic ops
plus: x and: y
	^ bcGenerator plus: [ x argString: parser ] and: [ y argString: parser ]