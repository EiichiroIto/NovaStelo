accessing
invOperatorAt: aSymbol ifAbsent: aBlock
	^ InvOperatorDict at: aSymbol asSymbol ifAbsent: aBlock