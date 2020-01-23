variable ops
setPatchColorTo
	| color pid |
	color := self pop.
	pid := self pop.
	world var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: pid put: color.