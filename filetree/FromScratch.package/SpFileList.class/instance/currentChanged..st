private
currentChanged: aString
	| dir |
	listHierarchy selectedIndex = 0
		ifTrue: [ ^ self ].
	dir := directory.
	directory path segments size - listHierarchy selectedIndex
		timesRepeat: [ dir := dir parent ].
	self directory: dir