fixed format-reading
getForm: anObject id: classID

	| w h d offset bits result |
	firstPass ifTrue: [
		w := self readField.
		h := self readField.
		d := self readField.
		offset := self readField.
		bits := self readField.
		result := (self classForID: classID) basicNew
			setExtent: w@h depth: d bits: bits;
			offset: offset.
		(result class = ColorForm) ifTrue: [result privateColors: self readField].
		^ result].

	"fix references"
	anObject bits: (self targetObjectFor: anObject bits).
	anObject offset: (self targetObjectFor: anObject privateOffset).
	(anObject class = ColorForm) ifTrue: [anObject privateColors: (self targetObjectFor: anObject privateColors)].

