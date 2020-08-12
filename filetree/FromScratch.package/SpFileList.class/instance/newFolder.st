private
newFolder
	| name |
	name := UIManager default request: 'New folder name:' localized.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	[ (directory / name) createDirectory ]
		ifError:
			[ :err :rcvr | ^ UIManager default alert: 'Could not create folder!' localized ].
	self directory: directory / name