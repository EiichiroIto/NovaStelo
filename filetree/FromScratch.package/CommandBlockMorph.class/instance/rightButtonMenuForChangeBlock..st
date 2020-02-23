menus
rightButtonMenuForChangeBlock: anEvent
	| menu choice spec |
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	"menu add: 'help' selector: #value: argument: #presentHelpScreen."
	menu addLine.
	(#(+ - * / \\) includes: selector)
		ifTrue: [ #(+ - * / mod)
				with: #(+ - * / \\)
				do: [ :s :op | menu add: s selector: #value: argument: op ] ].
	(#(< = >) includes: selector)
		ifTrue: [ #(< = >) do: [ :op | menu add: op selector: #value: argument: op ] ].
	(#(& |) includes: selector)
		ifTrue: [ #(and or)
				with: #(& |)
				do: [ :s :op | menu add: s selector: #value: argument: op ] ].
	menu addLine.
	menu localize.
	menu invokeAt: anEvent cursorPoint in: self world.
	choice ifNil: [ ^ self ].
	spec := '%n ' , choice , ' %n'.
	'\\' = choice
		ifTrue: [ spec := '%n mod %n' ].
	'&' = choice
		ifTrue: [ spec := '%b and %b' ].
	'|' = choice
		ifTrue: [ spec := '%b or %b' ].
	self commandSpec: spec.
	self selector: choice