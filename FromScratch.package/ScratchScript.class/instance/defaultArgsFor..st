blocks
defaultArgsFor: blockSpec
	| defaultArgs sel |
	defaultArgs := blockSpec copyFrom: 4 to: blockSpec size.
	sel := (blockSpec at: 3) asSymbol.
	(#(broadcast: doBroadcastAndWait) includes: sel)
		ifTrue: [ defaultArgs := Array with: project defaultEventName ].
	^ defaultArgs