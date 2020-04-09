instance creation
setPlotYMin: aNumber
	^ ScratchPlotCommand new
		command: ScratchPlotCommand setPlotYMin;
		args: { aNumber };
		yourself