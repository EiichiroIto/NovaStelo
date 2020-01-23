processes
startProcessFor: topBlock
	| code program |
	self stopAllProcesses.
	self setupEvents.
	code := self newCode parse: topBlock target: presenter target.
	program := self newProgram.
	program
		addCode: code;
		addEntryPoint: 1
			eventNo: EventId singleEventNo
			breedNo: topBlock receiver breedNo.
	process := sworld newProcess program: program.
	process single.
	^ process