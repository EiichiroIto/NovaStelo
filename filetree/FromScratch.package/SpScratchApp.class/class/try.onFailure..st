accessing
try: aBlock onFailure: anErrorBlock
	self useErrorCatcher
		ifTrue: [ aBlock ifError: anErrorBlock ]
		ifFalse: aBlock value