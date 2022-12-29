Extension { #name : #SpRequestDialog }

{ #category : #'*FromScratch' }
SpRequestDialog >> initializePresenters [

	image := self newImage image: self defaultIcon.
	label := self newLabel.
	textInput := self newTextInput.
	textInput
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self accept ];
		bindKeyCombination: Character escape asKeyCombination
		toAction: [ self cancel ]
]

{ #category : #'*FromScratch' }
SpRequestDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ 
			textInput
				takeKeyboardFocus;
				selectAll ]
]
