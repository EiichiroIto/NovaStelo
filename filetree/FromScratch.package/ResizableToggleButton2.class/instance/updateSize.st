private
updateSize
	"Set this button size based on the label size. Assume the label has already been set."

	| trim contentsExtent |
	trim := ScratchTranslator verticalTrimForFont: label2 font.
	contentsExtent := 0@0.
	self submorphsDo: [: m |
		(m isKindOf: ImageFrameMorph) ifFalse: [
			contentsExtent := (contentsExtent x max: m width)@(contentsExtent y + m height)]].
	self extent: contentsExtent + padding - (0@trim).
	vOffset := ScratchTranslator centerOffsetForButtonWithFont: label2 font.
	self updateLayout.
