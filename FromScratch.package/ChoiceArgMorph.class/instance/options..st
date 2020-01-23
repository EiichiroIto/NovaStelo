accessing
options: stringList

	options := stringList asArray.
	(options includes: choice) ifFalse: [self choice: options first].
