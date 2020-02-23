test
testParseCommandSpec
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc %n')
		equals: #(abc '%n').
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc %n    def %s')
		equals: #(abc '%n' def '%s').
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc%n1def%s23gh')
		equals: #(abc '%n1' def '%s23' gh).
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc% def%')
		equals: #(abc '%' def '%')