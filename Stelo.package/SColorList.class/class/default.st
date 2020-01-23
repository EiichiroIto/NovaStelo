accessing
default
	"SColorList default."

	DefaultList ifNil: [ DefaultList := self new ].
	^ DefaultList