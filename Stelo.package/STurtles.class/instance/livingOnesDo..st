microworld
livingOnesDo: aBlock
	1 to: self size do: [ :each | 
		(self flag: varId class aliveFlagNo at: each)
			ifTrue: [ aBlock value: each ] ]