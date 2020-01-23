instance creation
setPlotYMin: aNumber
	^ SteloPlotCommand new
		command: SteloPlotCommand setPlotYMin;
		args: { aNumber };
		yourself