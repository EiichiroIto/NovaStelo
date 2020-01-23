accessing
directory: aFileReference
	directory := aFileReference.
	self listHierarchyContents: self directoryHierarchy.
	self listEntriesContents: self getEntries