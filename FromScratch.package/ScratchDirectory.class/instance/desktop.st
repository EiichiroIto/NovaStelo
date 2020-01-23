private
desktop
	| fr |
	fr := self documents parent.
	(fr / 'Desktop') isDirectory
		ifFalse: [ ^ fr ].
	^ fr / 'Desktop'