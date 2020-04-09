private
export: anExporter extension: aString isBinary: aBoolean
	| str |
	str := self class
		try: [ anExporter exportFrom: self isBinary: aBoolean ]
		onFailure: [ :err | 
			UIManager default
				alert: 'Could not generate code:' , err asString
				title: 'Export failed' localized ].
	self exportString: str extension: aString isBinary: aBoolean