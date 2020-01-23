basic ops
turtlesCount: bno
	^ bcGenerator
		getObserverVar: SObserverVarDef countAliveVarNo
		arg: (bno argString: parser)