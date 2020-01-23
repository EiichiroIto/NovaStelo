private
importWorld: aCollection
	aCollection first = appName
		ifFalse: [ self error ].
	aCollection second do: [ :each | project assureExistsBreed: each ].
	self importScripts: aCollection third