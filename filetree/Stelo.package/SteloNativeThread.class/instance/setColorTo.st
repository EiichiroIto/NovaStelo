variable ops
setColorTo
	| color |
	color := self pop.
	world var: STurtleVarDef colorVarNo breed: breedId at: id put: color.