*FromScratch
localized
	"Answer myself translated into the current Scratch language. If there is no translation for me, then answer myself."

	"| selfAsString |
	selfAsString := self asString.
	ScratchTranslator addUITranslation: selfAsString.
	^ ScratchTranslator translationFor: selfAsString."
	^ self