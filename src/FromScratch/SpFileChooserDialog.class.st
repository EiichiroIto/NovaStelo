Class {
	#name : #SpFileChooserDialog,
	#superclass : #SpPresenter,
	#instVars : [
		'shortcuts',
		'fileList',
		'title',
		'textFilename',
		'fileInfo'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpFileChooserDialog class >> chooseExistingFileSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				yourself);
		yourself
]

{ #category : #specs }
SpFileChooserDialog class >> chooseNewFileSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				add: #textFilename
					withConstraints: [ :constraints | constraints expand: false ];
				yourself);
		yourself
]

{ #category : #specs }
SpFileChooserDialog class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				add: #filename
					withConstraints: [ :constraints | constraints expand: false ];
				yourself);
		yourself
]

{ #category : #specs }
SpFileChooserDialog class >> openScratchFileSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				yourself);
		add: #fileInfo;
		yourself
]

{ #category : #specs }
SpFileChooserDialog class >> saveScratchFileSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #shortcuts
			withConstraints: [ :constraints | constraints width: self shortcutButtonWidth ];
		add:
			(SpBoxLayout newVertical
				spacing: 4;
				add: #fileList;
				add: #textFilename
					withConstraints: [ :constraints | constraints expand: false ];
				yourself);
		add: #fileInfo;
		yourself
]

{ #category : #private }
SpFileChooserDialog class >> shortcutButtonWidth [
	^ 160
]

{ #category : #accessing }
SpFileChooserDialog >> author [
	^ fileInfo author
]

{ #category : #accessing }
SpFileChooserDialog >> author: aString [
	fileInfo author: aString
]

{ #category : #accessing }
SpFileChooserDialog >> comment [
	^ fileInfo comment
]

{ #category : #accessing }
SpFileChooserDialog >> comment: aString [
	fileInfo comment: aString
]

{ #category : #initialization }
SpFileChooserDialog >> connectPresenters [
	shortcuts list: fileList
]

{ #category : #accessing }
SpFileChooserDialog >> extension [
	^ fileInfo extension
]

{ #category : #accessing }
SpFileChooserDialog >> extension: aString [
	fileInfo extension: aString.
	fileList pattern: '*.' , aString
]

{ #category : #accessing }
SpFileChooserDialog >> filename [
	| ret |
	ret := textFilename pendingText asString.
	^ ret ifEmpty: [ nil ] ifNotEmpty: [ fileList directory / ret ]
]

{ #category : #accessing }
SpFileChooserDialog >> filename: aString [
	textFilename text: aString
]

{ #category : #initialization }
SpFileChooserDialog >> initialize [
	super initialize.
	title := self class asString
]

{ #category : #initialization }
SpFileChooserDialog >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog closeOnBackdropClick: false;
	askOkToClose: true
]

{ #category : #initialization }
SpFileChooserDialog >> initializePresenters [
	shortcuts := self instantiate: SpShortcutButtons.
	fileList := self instantiate: SpFileList.
	textFilename := self instantiate: SpLabelledTextInput.
	fileInfo := self instantiate: SpFileInfo.
	textFilename
		label: 'Filename:';
		acceptOnCR: true.
	self focusOrder
		add: fileList;
		add: textFilename
]

{ #category : #initialization }
SpFileChooserDialog >> initializeWindow: aWindow [
	aWindow title: title;
	initialExtent: 600 @ 400
]

{ #category : #private }
SpFileChooserDialog >> itemSelected [
	fileInfo file: fileList selectedFile
]

{ #category : #accessing }
SpFileChooserDialog >> project: aProject [
	fileInfo project: aProject
]

{ #category : #accessing }
SpFileChooserDialog >> selectedFile [
	^ fileList selectedFile
]

{ #category : #initialization }
SpFileChooserDialog >> setupForFileInfoEditor [
	fileInfo readOnly: false.
	textFilename label: 'New filename:'
]

{ #category : #initialization }
SpFileChooserDialog >> setupForFileInfoViewer [
	fileList whenFileSelectedBlock: [ self itemSelected ].
	fileInfo readOnly: true
]

{ #category : #accessing }
SpFileChooserDialog >> title: aString [
	title := aString
]

{ #category : #accessing }
SpFileChooserDialog >> type: aSymbol [
	shortcuts setDirectory: (ScratchDirectory current getLastFolderForType: aSymbol)
]
