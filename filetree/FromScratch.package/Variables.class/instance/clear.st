accessing
clear
	vars ifNil: [ ^ self ].
	vars do: [ :each | each ifNotNil: #reset ].