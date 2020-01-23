private
isPluginAvailable
	[ SteloLibCall new getErrorMessage ] ifError: [ ^ false ].
	^ true