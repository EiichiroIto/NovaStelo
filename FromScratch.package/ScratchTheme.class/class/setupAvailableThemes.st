initialization
setupAvailableThemes
	| dict theme |
	dict := Dictionary new.
	('Themes' asFileReference directoryNames copyWithout: 'common')
		do: [ :each | 
			theme := self perform: ('build' , each asCamelCase) asSymbol.
			dict at: each asSymbol put: theme ].
	AvailableThemes := dict