accessing
operatorAt: aSymbol ifAbsent: aBlock
	^ OperatorDict at: aSymbol asSymbol ifAbsent: aBlock