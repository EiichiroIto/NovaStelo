initialization
initializePresenters
	thumbnail := self newImage.
	textAuthor := self newTextInput acceptOnCR: true.
	textComment := self newText.
	labelAuthor := self newLabel label: 'Project author:'.
	labelComment := self newLabel label: 'About this project:'