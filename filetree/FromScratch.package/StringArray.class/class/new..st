instance creation
new: anInteger
	^ self new
		forceTo: anInteger paddingWith: '';
		yourself