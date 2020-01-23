private
changeParentDirectory
	directory isRoot ifTrue: [ ^ self ].
	self directory: directory parent