specs
defaultSpec
	^ SpBoxLayout newHorizontal
		add: #buttonObserver;
		add: #buttonPatches;
		add: #buttonTurtles;
		add:
			(SpBoxLayout newVertical
				add: #buttonAddTurtles;
				add: #buttonDeleteTurtles;
				yourself)
			withConstraints: [ :c | c width: 40 ];
		yourself