accessing
useErrorCatcher
	^ self settings at: #useErrorCatcher ifAbsent: [ false ]