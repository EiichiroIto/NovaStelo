private
writeScripts: aCollection
	aCollection do: [ :each | self writeScript: each ].