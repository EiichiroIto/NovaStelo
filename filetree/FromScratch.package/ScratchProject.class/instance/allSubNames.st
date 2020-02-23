accessing
allSubNames
	| result |
	result := Set new.
	self scripts do: [ :each | result addAll: each subNames ].
	^ result asArray sort