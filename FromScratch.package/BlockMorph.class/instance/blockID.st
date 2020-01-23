accessing
blockID
	"answer a temporary (!) id for the receiver
	which can be used for tuple conversion of
	sticky comments"

	| sm |
	sm := self script.
	sm ifNil: [ ^ nil ].
	^ sm blockIDOf: self