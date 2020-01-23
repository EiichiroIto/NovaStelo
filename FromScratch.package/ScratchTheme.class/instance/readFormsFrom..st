file read
readFormsFrom: aFileReference
	| img fn |
	aFileReference files
		do: [ :entry | 
			fn := entry fullName.
			Cursor read showWhile: [ img := [ Form fromFileNamed: fn ] ifError: [ self error	"nil" ] ].
			img ifNotNil: [ self formAt: entry base asSymbol put: img ] ].