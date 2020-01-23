accessing
allEventNames
	"Answer a list of all events that have been defined in this project."

	| result |
	result := Set new: 100.
	self scripts do: [ :m | m addEventNamesTo: result ].
	result remove: '' ifAbsent: [  ].
	^ result asArray sort