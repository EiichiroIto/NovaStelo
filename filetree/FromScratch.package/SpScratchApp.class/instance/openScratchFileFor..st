private
openScratchFileFor: aProject
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: self extension;
		project: aProject;
		setupForFileInfoViewer;
		title: 'Open Project' localized;
		type: #project.
	d := dialog openModalWithSpec: #openScratchFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog selectedFile