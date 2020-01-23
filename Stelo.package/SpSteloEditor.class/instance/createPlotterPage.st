private
createPlotterPage
	| morph |
	plotter := self newMorph.
	morph := ScrollFrameMorph2 new
		growthFraction: 0.1;
		color: Color black;
		yourself.
	morph contents color: (Color gray: 0.5).
	plotter morph: morph.
	^ SpNotebookPage
		title: self plotterLabel
		icon: (self iconNamed: #morph)
		provider: [ plotter ]