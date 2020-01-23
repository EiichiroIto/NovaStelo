private
setupOpTable
	OpTable := Array new: cachedSymbols size.
	cachedSymbols
		withIndexDo: [ :each :index | OpTable at: index put: each ].