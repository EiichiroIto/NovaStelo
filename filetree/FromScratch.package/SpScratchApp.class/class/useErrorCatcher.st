accessing
useErrorCatcher
	^ self options at: #useErrorCatcher ifAbsent: [ false ]