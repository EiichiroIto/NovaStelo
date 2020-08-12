private
fontFromString: aString
	| ret family point |
	(aString includes: $:)
		ifFalse: [ ^ nil ].
	ret := aString splitOn: $:.
	family := ret first trimBoth.
	point := ret second asNumberNoError max: 5.
	^ LogicalFont familyName: family pointSize: point