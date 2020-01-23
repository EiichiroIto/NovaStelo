specs
defaultSpec
	^ SpBoxLayout newVertical
		spacing: 4;
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #listHierarchy;
				add: #buttonParent withConstraints: [ :constraints | constraints expand: false ];
				add: #buttonNew withConstraints: [ :constraints | constraints expand: false ];
				yourself)
			withConstraints: [ :constraints | constraints expand: false ];
		add: #listEntries;
		yourself