microworld
create: anInteger
	| rest tno list |
	rest := anInteger.
	list := OrderedCollection new.
	tno := 1.
	[ rest > 0 ]
		whileTrue: [ (self aliveAt: tno)
				ifFalse: [ self setupAt: tno.
					list add: tno.
					rest := rest - 1 ].
				tno := tno + 1 ].
	^ list