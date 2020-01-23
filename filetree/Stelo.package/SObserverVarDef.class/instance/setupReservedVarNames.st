private
setupReservedVarNames
	#(width height maxBreedNo ticks countAlive size maxVar)
		do: [ :each | 
			self
				addComputedVariable: each
				varNo: (self class perform: each , 'VarNo') ].
	self setupVarNames