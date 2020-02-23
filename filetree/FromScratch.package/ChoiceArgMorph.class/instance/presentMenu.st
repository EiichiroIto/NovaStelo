accessing
presentMenu
	"Pop up a menu of choices."

	| optionList list lines pos |
	optionList := self options.
	optionList isEmpty
		ifTrue: [ ^ self ].
	list := WriteStream on: Array new.
	lines := WriteStream on: Array new.
	pos := 0.
	optionList
		do: [ :each | 
			each = '-'
				ifTrue: [ lines nextPut: pos ]
				ifFalse: [ list nextPut: each.
					pos := pos + 1 ] ].
	list := list contents.
	lines := lines contents.
	pos := UIManager default
		chooseFrom:
			((#(varNames) includes: getOptionsSelector)
				ifTrue: [ list ]
				ifFalse: [ list collect: #localized ])
		lines: lines.
	pos = 0 ifTrue: [ ^ self ].
	self choice: (list at: pos)