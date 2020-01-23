specs
defaultSpec
	^ SpBoxLayout newVertical
		add: #labelVars withConstraints: [ :c | c expand: false ];
		add: #tableVars;
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #buttonRefresh;
				add: #buttonDelete;
				yourself) withConstraints: [ :c | c expand: false ];
		yourself