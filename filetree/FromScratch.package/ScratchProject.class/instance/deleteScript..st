private
deleteScript: aScript
	scripts := scripts copyWithoutIndex: (scripts indexOf: aScript)