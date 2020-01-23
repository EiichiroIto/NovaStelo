private
importScripts: aCollection for: aScript
	aCollection
		do: [ :each | 
			each first = 'when'
				ifTrue: [ self importEvent: each third for: aScript eventName: each second ].
			each first = 'sub'
				ifTrue: [ self importSub: each third for: aScript subName: each second ]].
	aScript cleanUp