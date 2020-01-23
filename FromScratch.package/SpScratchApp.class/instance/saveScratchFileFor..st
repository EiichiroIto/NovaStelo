private
saveScratchFileFor: aProject
	| dialog |
	dialog := SpFileChooserDialog new.
	dialog
		filename: self projectName;
		extension: self extension;
		setupForFileInfoEditor;
		title: 'Save Project';
		type: #project;
		author: aProject author;
		comment: aProject comment.
	[ (dialog openModalWithSpec: #saveScratchFileSpec) isCancelled
		ifTrue: [ ^ nil ].
	dialog filename isNil ] whileTrue.
	aProject
		author: dialog author;
		comment: dialog comment.
	^ dialog filename