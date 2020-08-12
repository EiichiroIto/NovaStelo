file read/write
readProjectFrom: aFileReference
	| f projData newProj |
	f := aFileReference binaryReadStream.
	f
		ifNil: [ UIManager default
				alert: 'Could not read file: ' localized , aFileReference pathString
				title: 'Load failed' localized.
			^ nil ].
	SpScratchApp
		try: [ projData := f contents.
			newProj := self extractProjectFrom: projData.
			newProj extractInfoFrom: projData ]
		onFailure: [ :err :rcvr | 
			UIManager default
				alert: err
				title: 'Could not read project; file may be damaged' localized.
			^ nil ].
	self modified: false.
	^ newProj