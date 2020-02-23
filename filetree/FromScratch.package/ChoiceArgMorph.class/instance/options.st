accessing
options
	"Answer my set of options. If getOptionsSelector is not nil and I'm in a CommandBlock with a non-nil receiver, fetch my set of options by sending getOptionsSelector to that receiver."

	getOptionsSelector ifNil: [ ^ options ].
	getOptionsTarget
		ifNotNil: [ ^ getOptionsTarget perform: getOptionsSelector ].
	^ owner receiver perform: getOptionsSelector