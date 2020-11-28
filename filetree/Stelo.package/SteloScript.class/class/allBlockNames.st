accessing
allBlockNames
	"self allBlockNames"
	| list |
	list := Set new.
	self
		subclassesDo: [ :each | 
			(each new blocks reject: [ :each2 | each2 isString ])
				do: [ :each3 | list add: each3 first ] ].
	^ list asArray sorted