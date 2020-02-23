private
export: anExporter extension: aString
	| str |
	str := self class
		try: [ anExporter exportFrom: self ]
		onFailure: [ :err | 
			UIManager default
				alert: 'Could not generate code:' , err asString
				title: 'Export failed' localized ].
	self exportString: str extension: aString