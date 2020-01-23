accessing
backupBreeds: aCollection
	aCollection do: [ :each | self getAllVariables: each ].