testing
isStop

	^ (selector = #stopThread) | (selector = #stopAll) | (selector = #return:)