private
createPlotterPage
	plotter := self newMorph.
	plotter morph: self newPlotter.
	^ SpNotebookPage
		title: self plotterLabel
		icon: (self iconNamed: #morph)
		provider: [ plotter ]