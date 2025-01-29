Extension { #name : 'SpRequestDialog' }

{ #category : '*FromScratch' }
SpRequestDialog >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [ 
		textInput
			takeKeyboardFocus;
			selectAll ]
]
