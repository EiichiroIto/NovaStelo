menu actions
editNotes
	| ret |
	ret := UIManager default
		multiLineRequest: 'Project Notes' localized
		initialAnswer: project comment
		answerHeight: 450.
	ret ifNil: [ ^ self ].
	project comment: ret