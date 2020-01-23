blocks
addVariableReportersTo: page x: x y: startY
	| y b watcherButton yOffset |
	y := startY.
	self varNames
		do: [ :vName | 
			b := VariableBlockMorph new
				commandSpec: vName;
				receiver: self.
			watcherButton := self createToggleButtonFor: b.
			yOffset := (b fullBounds height - watcherButton height) // 2.
			self useVariableWatcher
				ifTrue: [ page addMorph: (watcherButton position: x @ (y + yOffset)) ].
			page addMorph: (b position: (x + watcherButton width + 4) @ y).
			y := y + b height + 3 ].
	^ y