private
argSpecs
	^ (self class parseCommandSpec: commandSpec)
		select: [ :s | self class isArgSpec: s ]