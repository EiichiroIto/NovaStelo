accessing
target: anObject
	| current |
	current := self currentCategory.
	target := anObject.
	target ifNil: [ ^ self currentCategory: nil ].
	self categories: target blockCategories.
	self currentCategory: current.
	self currentCategory ifNil: [ categories selectIndex: 1 ]