accessing
sworld: aWorld
	sworld ifNotNil: [ self backupProject ].
	sworld := aWorld.
	project ifNotNil: [ self restoreProject ].
	presenter sworld: aWorld.
	self updateStatus