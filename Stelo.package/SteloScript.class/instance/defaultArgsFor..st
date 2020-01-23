blocks
defaultArgsFor: blockSpec
	| sel turtles lists args |
	sel := (blockSpec at: 3) asSymbol.
	args := blockSpec copyFrom: 4 to: blockSpec size.
	turtles := self project scriptsForMenu.
	turtles notEmpty
		ifTrue: [ (#(turtlesCount: clearTurtle:) includes: sel)
				ifTrue: [ ^ args
						at: 1 put: turtles first;
						yourself ].
			(#(#createTurtleSize:breedId: #kill:breed:) includes: sel)
				ifTrue: [ ^ args
						at: 2 put: turtles first;
						yourself ] ].
	lists := self listVarNames.
	lists notEmpty
		ifTrue: [ (#(clearList: lineCountOfList: #list:contains:) includes: sel)
				ifTrue: [ ^ args
						at: 1 put: lists first;
						yourself ].
			(#(#append:toList: #deleteLine:ofList: #getLine:ofList: #setLine:ofList:to:)
				includes: sel)
				ifTrue: [ ^ args
						at: 2 put: lists first;
						yourself ] ].
	^ super defaultArgsFor: blockSpec