basic ops
turtlesCount: bno
	^ generator
		getObserverVar: SObserverVarDef countAliveVarNo
		arg: (bno argString: parser)