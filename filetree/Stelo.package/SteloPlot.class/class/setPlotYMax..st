instance creation
setPlotYMax: aNumber
	^ SteloPlotCommand new
		command: SteloPlotCommand setPlotYMax;
		args: { aNumber };
		yourself