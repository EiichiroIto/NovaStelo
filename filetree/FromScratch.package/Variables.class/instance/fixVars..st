private
fixVars: varId
	| desirableClass |
	self updateVarDef: varId.
	vars
		withIndexDo: [ :each :index | 
			each
				ifNotNil: [ desirableClass := varId classNameForVarNo: index.
					desirableClass
						ifNil: [ vars at: index put: nil ]
						ifNotNil: [ each className ~= desirableClass
								ifTrue: [ self error. vars at: index put: (each className: desirableClass) ] ] ] ]