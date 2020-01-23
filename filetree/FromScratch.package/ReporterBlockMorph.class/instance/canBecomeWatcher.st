watcher
canBecomeWatcher
	^ self isReporter
		and: [ self argumentCount <= 1
				and:
					[ self script watcherSelectors includes: selector ] ]