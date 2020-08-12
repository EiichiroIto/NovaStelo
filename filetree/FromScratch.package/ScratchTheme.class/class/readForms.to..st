private
readForms: aString to: aTheme
	| base dir |
	base := 'Themes' asFileReference.
	base exists
		ifFalse: [ self error: 'Themes folder not found!' ].
	dir := base / 'common'.
	dir isDirectory
		ifFalse: [ self error: 'common folder not found!' ].
	aTheme readFormsFrom: dir.
	dir := base / aString.
	dir isDirectory
		ifFalse: [ self error: 'That folder not found: ' , aString ].
	aTheme readFormsFrom: dir