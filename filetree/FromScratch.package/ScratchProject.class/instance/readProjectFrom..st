file read/write
readProjectFrom: aFileReference
	| f projData newProj |
	f := aFileReference binaryReadStream.
	f
		ifNil: [ UIManager default
				alert: aFileReference pathString
				title: 'Could not read' localized.
			^ nil ].
	SpScratchApp
		try: [ projData := f contents.
			newProj := self extractProjectFrom: projData.
			newProj extractInfoFrom: projData ]
		onFailure: [ :err :rcvr | 
			UIManager default
				alert: err
				title: 'Could not read project; file may be damaged'.
			^ nil ].
	^ newProj