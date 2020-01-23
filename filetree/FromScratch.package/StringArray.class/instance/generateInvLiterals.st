private
generateInvLiterals
	| dict |
	dict := Dictionary new.
	literals withIndexDo: [ :each :index | dict at: each put: index ].
	^ dict