specs
defaultSpec
	^ SpBoxLayout newHorizontal
		add: #buttonMain;
		add: #buttonOther;
		add: #buttonAdd withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonSelect withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonDelete withConstraints: [ :c | c width: self buttonWidth ];
		yourself