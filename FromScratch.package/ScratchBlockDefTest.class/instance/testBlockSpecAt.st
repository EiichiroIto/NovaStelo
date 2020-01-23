test
testBlockSpecAt
	| sp list |
	sp := self newBlockDef.
	list := #(
			'sensing'
			('return value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assertCollection: (sp blockSpecAt: #returnValue) equals: #('return value' r #returnValue).
	self assertCollection: (sp blockSpecAt: #+) equals: #('%n + %n' r #+ #- #-).
	self assertCollection: (sp blockSpecAt: #-) equals: #('%n - %n' r #- #- #-)