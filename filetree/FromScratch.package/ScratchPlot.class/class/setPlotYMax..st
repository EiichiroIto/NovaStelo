instance creation
setPlotYMax: aNumber
	^ ScratchPlotCommand new
		command: ScratchPlotCommand setPlotYMax;
		args: { aNumber };
		yourself