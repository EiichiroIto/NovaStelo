private
readForms: aString to: aTheme 
	| base dir |
	base := 'Themes' asFileReference.
	base exists
		ifFalse: [self error: 'Themes directory not found'].
	dir := base / 'common'.
	dir isDirectory
		ifFalse: [self error: 'common directory not found'].
	aTheme readFormsFrom: dir.
	dir := base / aString.
	dir isDirectory
		ifFalse: [self error: aString , ' directory not found'].
	aTheme readFormsFrom: dir.