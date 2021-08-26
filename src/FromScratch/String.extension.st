Extension { #name : #String }

{ #category : #'*FromScratch' }
String >> asNumberNoError [
	"Convert the given string to a number without giving errors about its format. Ignore non-digit characters and allow a leading '+', which kids sometimes type. Answer zero if empty."

	| s sign ch body |
	self size = 0 ifTrue: [^ 0].
	s := ReadStream on: self.
	s skipSeparators.

	"read sign character, if any"
	sign := 1.
	ch := s peek.
	(ch = $+) | (ch = $-) ifTrue: [
		ch = $- ifTrue: [sign := -1].
		s skip: 1].

	body := WriteStream on: (String new: 40).
	body nextPut: $0.
	[s atEnd not and: [s peek isDigit]] whileTrue: [body nextPut: s next].  "read digits before decimal point"
	('.,' includes: s peek) ifTrue: [  "read decimal point (period or comma) and following digits, if any"
		s skip: 1.
		body nextPut: $..
		[s atEnd not and: [s peek isDigit]] whileTrue: [body nextPut: s next]].

	"read exponent"
	(s atEnd not and: ['eE' includes: s peek]) ifTrue: [
		s next.
		body nextPut: $e.
		(s atEnd not and: [s peek = $-]) ifTrue: [body nextPut: s next].		 "exponent sign"
		[s atEnd not and: [s peek isDigit]] whileTrue: [body nextPut: s next]].  "exponent"

	^ sign * (body contents asNumber)

]

{ #category : #'*FromScratch' }
String >> isNumberString [
	| aStream d pointNumber digitAppears |
	pointNumber := false.
	digitAppears := false.
	aStream := ReadStream on: self.
	aStream peek = $- ifTrue: [aStream next].
	[aStream atEnd]
		whileFalse: 
			[d := aStream next.
			d = $.
				ifTrue: 
					[pointNumber ifTrue: [^ false].
					pointNumber := true]
				ifFalse: [(d < $0 or: [d > $9])
						ifTrue: [^ false]
						ifFalse: [digitAppears := true]]].
	^ digitAppears
]

{ #category : #'*FromScratch' }
String >> isScriptable [
	^ false
]

{ #category : #'*FromScratch' }
String >> localized [
	"Answer myself translated into the current Scratch language. If there is no translation for me, then answer myself."

	"| selfAsString |
	selfAsString := self asString.
	ScratchTranslator addUITranslation: selfAsString."

	^ ScratchTranslator translationFor: self asString
]
