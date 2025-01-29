Extension { #name : 'OSSDL2BackendWindow' }

{ #category : '*FromScratch' }
OSSDL2BackendWindow >> visitTextInputEvent: event [

	| osEvent text last |
	text := ZnUTF8Encoder new decodeBytes: event text.
	text do: [ :each | 
		last := each.
		osEvent := OSTextInputEvent for: osWindow.
		osEvent
			text: each asString;
			position: self mousePosition.
		osEvent deliver ].
	^ last
]
