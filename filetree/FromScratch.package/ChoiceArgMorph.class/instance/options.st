private
options
	"Answer my set of options. If getOptionsSelector is not nil and I'm in a CommandBlock with a non-nil receiver, fetch my set of options by sending getOptionsSelector to that receiver."

	^ self getOptionsSelector
		ifNil: [ #() ]
		ifNotNil:
			[ :selector | (self getOptionsTarget ifNil: [ owner receiver ]) perform: selector ]