specs
openScratchFileSpec
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				yourself);
		add: #fileInfo;
		yourself