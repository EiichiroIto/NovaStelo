private
changePluginWorld
	sworldMode = #SPluginWorld
		ifTrue: [ ^ self ].
	sworldMode := #SPluginWorld.
	self sworld: self newWorld