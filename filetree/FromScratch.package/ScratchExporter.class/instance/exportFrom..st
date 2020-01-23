accessing
exportFrom: anApplication
	| project |
	project := anApplication project.
	stream := WriteStream on: ''.
	self writeHeader: project.
	self writeScripts: project scripts.
	self writeFooter: project.
	^ stream contents