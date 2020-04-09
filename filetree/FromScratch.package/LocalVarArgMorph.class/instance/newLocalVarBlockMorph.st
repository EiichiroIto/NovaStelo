private
newLocalVarBlockMorph
	^ LocalVarBlockMorph new
		commandSpec: self varName;
		receiver: owner receiver