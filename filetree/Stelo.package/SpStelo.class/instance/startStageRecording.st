menu actions
startStageRecording
	| ext fName |
	ext := 'gif'.
	fName := self
		chooseNewFileDefault: ''
		extension: ext
		title: 'Start Stage Recording'
		type: #snapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: ext.
	fName exists
		ifTrue: [ (self
				confirm: 'Are you sure you want to overwrite the file''' , fName basename , '''?')
				ifFalse: [ ^ self ].
			fName delete ].
	recorder := ScratchRecorder new
		openFileNamed: fName;
		model: presenter;
		extent: 200 @ 200.
	self updateStatus