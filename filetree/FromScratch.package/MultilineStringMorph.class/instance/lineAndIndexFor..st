private
lineAndIndexFor: charPos
	"Answer an Array containing the line number and the character index within that line for the given character position in my text."

	| count line |
	charPos < 1 ifTrue: [^ Array with: 1 with: 1].

	count := 0.
	1 to: lines size do: [:lineNum |
		line := lines at: lineNum.
		(charPos between: count + 1 and: count + line size)
			ifTrue: [^ Array with: lineNum with: charPos - count].
		count := count + line size].
	
	^ Array with: lines size with: ((lines at: lines size) size + 1)
