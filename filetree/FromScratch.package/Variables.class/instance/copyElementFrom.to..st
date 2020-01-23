accessing
copyElementFrom: anInteger1 to: anInteger2
	vars do: [ :each | each at: anInteger2 put: (each at: anInteger1) ].