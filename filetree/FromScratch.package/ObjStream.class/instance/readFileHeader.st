private-reading
readFileHeader
	"Read the file header on my stream."

	(((stream next: 4) asString = 'ObjS') &
	 (stream next = 1) &
	 ((stream next: 4) asString = 'Stch') &
	 (stream next = 1)) ifFalse: [
		self error: 'bad header'].
