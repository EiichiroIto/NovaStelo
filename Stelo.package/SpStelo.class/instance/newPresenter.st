private
newPresenter
	^ SpSteloFrame basicNew
		application: self;
		initialize;
		whenStepsDo: [ self stepProcesses ]