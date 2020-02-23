control ops
broadcast: msg
	| eno |
	eno := msg argString: parser.
	eno ifNil: [ ^ self ].
	generator broadcast: eno