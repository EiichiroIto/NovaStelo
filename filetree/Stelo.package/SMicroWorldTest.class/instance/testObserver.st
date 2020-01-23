tests-accessing
testObserver
	| w |
	w := self newWorld.
	self assert: w observer class equals: SObserver.