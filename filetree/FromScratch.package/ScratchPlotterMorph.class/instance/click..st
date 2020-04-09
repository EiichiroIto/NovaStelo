event handling
click: evt
	whenMouseClicked ifNil: [ ^ self ].
	whenMouseClicked cull: self cull: evt