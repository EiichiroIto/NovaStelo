private
newObserverScript
	^ ObserverScript new
		breed: application newObserver;
		project: self;
		yourself