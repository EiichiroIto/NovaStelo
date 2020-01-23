*FromScratch
updateTarget: anObject
	self items do: [ :each | each target ifNil: [ each target: anObject ] ]