accessing
reset
	array := self isFixed
		ifTrue: [ self arrayClass new: fixedSize ]
		ifFalse: [ nil ]