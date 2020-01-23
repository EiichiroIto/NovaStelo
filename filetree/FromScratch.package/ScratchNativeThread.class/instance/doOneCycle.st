private
doOneCycle
	| code |
	isRunning := true.
	[ pc > codes size
		ifTrue: [ ^ self error ].
	code := codes at: pc.
	pc := pc + 1.
	self perform: code.
	isRunning ] whileTrue.
	^ false