menus
rightButtonMenu: anEvent
	| menu choice spec |
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	"menu add: 'help' selector: #value: argument: #presentHelpScreen."
	owner isBlockPalette
		ifFalse: [ menu addLine.
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
			"menu add: 'duplicate' selector: #value: argument: #duplicate."
			self owner isBlockMorph
				ifFalse:
					[ "can't yet delete a blocks inside a script" menu add: 'delete' selector: #value: argument: #delete ] ].

	"sFrame := self meOrOwnerThatIsA: ScratchFrameMorph."
	"(sFrame notNil and: [#(sensor: sensorPressed:) includes: selector]) ifTrue: [
		menu addLine.
		menu add: 'show ScratchBoard watcher' selector: #value: argument: #showSensorBoard.
		sFrame workPane scratchServer
			ifNil: [menu add: 'enable remote sensor connections' selector: #value: argument: #enableRemoteSensors]
			ifNotNil: [menu add: 'disable remote sensor connections' selector: #value: argument: #exitScratchSession]]."

	"DebugMenu ifTrue: [
		menu addLine.
		menu add: 'show tuples' selector: #value: argument: #showTuples]."
	menu localize.
	menu invokeAt: anEvent cursorPoint in: self world.
	choice ifNil: [ ^ self ].
	(#(duplicate delete) includes: choice)
		ifTrue: [ ^ self perform: choice ].
	"choice = #showSensorBoard ifTrue: [sFrame showSensorBoard. ^ self].
	choice = #enableRemoteSensors ifTrue: [sFrame enableRemoteSensors. ^ self]."
	"choice = #exitScratchSession ifTrue: [sFrame exitScratchSession. ^ self]."
	"choice = #showTuples ifTrue: [^ self showTuples]."

	"change operator"
	spec := '%n ' , choice , ' %n'.
	'\\' = choice
		ifTrue: [ spec := '%n mod %n' ].
	'&' = choice
		ifTrue: [ spec := '%b and %b' ].
	'|' = choice
		ifTrue: [ spec := '%b or %b' ].
	self commandSpec: spec.
	self selector: choice