specs
defaultSpec
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				add: #filename
					withConstraints: [ :constraints | constraints expand: false ];
				yourself);
		yourself