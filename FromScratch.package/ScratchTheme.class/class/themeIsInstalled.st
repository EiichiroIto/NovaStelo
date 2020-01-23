testing
themeIsInstalled
	^ 'Themes' asFileReference in: [ :ref | ref isDirectory and: [ ref entries notEmpty ] ]