private
writeScripts: aCollection
	aCollection
		do: [ :each | self writeScript: each ]
		separatedBy: [ self writeScriptSeparator ]