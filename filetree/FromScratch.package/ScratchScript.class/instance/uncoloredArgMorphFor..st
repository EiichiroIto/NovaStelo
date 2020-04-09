argument menus
uncoloredArgMorphFor: specString
	argBuilder ifNil: [ self setupArgBuilder ].
	^ argBuilder uncoloredArgMorphFor: specString