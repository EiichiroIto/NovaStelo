acccessing
import: aString to: anApplication
	| plotter arr x |
	plotter := anApplication plotter.
	x := plotter numData.
	arr := self plotsFrom: aString.
	arr
		withIndexDo: [ :each :index | plotter plot: x + index list: each ].
	plotter updateCache