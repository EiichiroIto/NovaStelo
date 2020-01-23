accessing
applicationDo: aBlock
	^ self project ifNotNil: [ :p | aBlock value: p application ]