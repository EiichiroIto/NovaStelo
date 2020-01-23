specs
noDeleteButtonSpec
	^ SpBoxLayout newVertical
		add: #labelVars withConstraints: [ :c | c expand: false ];
		add: #tableVars;
		add:
			(SpBoxLayout newHorizontal
				add: #buttonRefresh;
				yourself) withConstraints: [ :c | c expand: false ];
		yourself