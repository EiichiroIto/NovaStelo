acccessing
import: aString to: anApplication
	| plotter arr x |
	project := anApplication project.
	plotter := (project scriptOf: SBreedId observerBreedNo) plotter.
	x := plotter numPlots.
	arr := self plotsFrom: aString.
	arr
		withIndexDo: [ :each :index | plotter plot: x + index list: each ].
	plotter updateCache