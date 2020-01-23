misc ops
plotColor
	| num color |
	color := self pop.
	num := self pop.
	world plot: num asInteger color: color asInteger