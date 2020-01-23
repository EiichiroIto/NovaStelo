accessing
userDefinedVarNoAndNames
	^ self userDefinedVarNames
		collect: [ :each | 
			{(self varNoFor: each).
			each} ]