initialization
connectPresenters
	buttonBasic action: [ self currentCategory: #basic ].
	buttonControl action: [ self currentCategory: #control ].
	buttonColor action: [ self currentCategory: #color ].
	buttonPatch action: [ self currentCategory: #patch ].
	buttonOperators action: [ self currentCategory: #operators ].
	buttonPen action: [ self currentCategory: #pen ].
	buttonVariables action: [ self currentCategory: #variables ].
	buttonSensing action: [ self currentCategory: #sensing ]