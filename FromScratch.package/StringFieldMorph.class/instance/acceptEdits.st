private
acceptEdits
	"Tell the client to accept edits."

	client ifNil: [^ self].
	(client respondsTo: #accept) ifTrue: [client accept].
	(client respondsTo: #acceptContents) ifTrue: [client acceptContents].
	(client respondsTo: #yes) ifTrue: [client yes].
