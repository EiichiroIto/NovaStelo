*FromScratch
hhmmss
	"Answer a string of the form HH:MM:SS. For displaying a time in seconds as hours, minutes, and seconds."

	| hh mm ss |
	hh := (self // 3600) printString.
	mm := (self // 60 \\ 60) printString.
	mm size < 2
		ifTrue: [ mm := '0' , mm ].
	ss := (self \\ 60) printString.
	ss size < 2
		ifTrue: [ ss := '0' , ss ].
	^ hh , ':' , mm , ':' , ss