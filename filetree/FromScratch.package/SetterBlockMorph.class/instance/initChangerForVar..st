initialization
initChangerForVar: varName
	self commandSpec: 'change %v by %n' localized.
	argPermutation := CommandBlockMorph
		argPermutationForSpec: 'change %v to %n'
		withTranslation: commandSpec.
	self selector: #changeVar:by:.
	self variable: varName