accessing
importCode: anArray into: aScript
	anArray first = 'when'
		ifTrue: [ ^ self
				importEvent: anArray third
				for: aScript
				eventName: anArray second ].
	anArray first = 'sub'
		ifTrue:
			[ ^ self importSub: anArray third for: aScript subName: anArray second ].
	anArray first isArray
		ifTrue:
			[ ^ self importCodes: anArray into: aScript ].
	^ nil