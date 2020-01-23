accessing
code
	| firstPass array out |
	firstPass := stream contents.
	array := self labelsAndJumpsFor: firstPass.
	self resolveJumpAddress: array second using: array first.
	out := WriteStream on: Array new.
	firstPass do: [ :each | each putOn: out ].
	out nextPut: #stop.
	^ out contents