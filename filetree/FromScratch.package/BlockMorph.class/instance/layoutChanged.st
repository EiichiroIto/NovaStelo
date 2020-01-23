private
layoutChanged

	blockLayoutNeeded ifFalse: [super layoutChanged].
	blockLayoutNeeded := true.

