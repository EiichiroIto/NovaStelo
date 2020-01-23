specs
defaultSpec
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #labelName;
				add: #labelStatus;
				yourself)
			withConstraints: [ :c | c expand: false ];
		add: #notebook;
		yourself