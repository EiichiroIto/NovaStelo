private
replacePlot: anInteger at: index put: value
	| old |
	old := data at: index.
	anInteger > old size
		ifTrue: [ old := old grownBy: anInteger - old size ].
	old at: anInteger put: value.
	data at: index put: old