processes
stepProcessesHook
	| list |
	recorder ifNotNil: [ recorder writeForced: false ].
	list := sworld plotList.
	list isEmpty
		ifTrue: [ ^ self ].
	presenter addPlots: list