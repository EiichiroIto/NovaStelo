specs
plotToListSpec
	^ SpBoxLayout newVertical
		spacing: 4;
		add: #labelPlots withConstraints: [ :c | c expand: false ];
		add: #dropPlots withConstraints: [ :c | c expand: false ];
		add: #labelListNames withConstraints: [ :c | c expand: false ];
		add: #dropListNames withConstraints: [ :c | c expand: false ];
		yourself