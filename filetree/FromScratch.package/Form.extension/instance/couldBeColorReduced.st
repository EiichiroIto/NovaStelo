*FromScratch
couldBeColorReduced
	"Answer true if this Form has few enough colors to be converted to a ColorForm, but answer false if quantizing it's colors in the process of creating the ColorForm would result in fewer colors than the original. (Note: Converting to a ColorForm may still result in small color shifts due to color quantization, buf if all the colors remain unique these shifts should not be too noticable.)"

	| colors pixel |
	self depth < 32 ifTrue: [^ false].
	self unhibernate.
	colors := Set new: 1000.
	1 to: bits size do: [:i |
		pixel := (bits at: i) bitAnd: 16rFFFFFF.
		pixel = 0 ifFalse: [
			colors add: pixel.
			colors size > 255 ifTrue: [^ false]]].

	^ colors size <= self colorsUsed size
