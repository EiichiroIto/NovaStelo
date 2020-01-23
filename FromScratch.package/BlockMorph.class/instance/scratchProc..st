processes
scratchProc: aScratchProcess

	hadError == true ifTrue: [cachedFeedbackForm := nil].
	hadError := false.
	scratchProc := aScratchProcess.
	self changed.
