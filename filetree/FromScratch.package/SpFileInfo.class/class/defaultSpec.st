specs
defaultSpec
	^ SpBoxLayout newVertical
		add: #thumbnail
			withConstraints: [ :c | c width: SpScratchApp thumbnailExtent x ];
		add: #labelAuthor withConstraints: [ :c | c expand: false ];
		add: #textAuthor withConstraints: [ :c | c expand: false ];
		add: #labelComment withConstraints: [ :c | c expand: false ];
		add: #textComment;
		yourself