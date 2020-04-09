accessing
stickyWindow
	^ self settings at: #stickyWindow ifAbsent: [ false ]