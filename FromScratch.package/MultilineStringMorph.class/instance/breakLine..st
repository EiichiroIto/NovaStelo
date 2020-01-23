private
breakLine: lineIndex
	"Break the given line by moving some of it down to the following line. Answer true if the line was broken, false otherwise. (This may cause the next line to become too long, thus propaging the need to word-wrap.)
	Try the following strategies, in order:
		a. break at an embedded if that leaves the line short enough
		b. break at the last space character before a word that hits the edge
		c. break a word that hits the edge if there is no space before that word"

	| line breakIndex i lineUpToBreak lineAfterBreak |
	line := lines at: lineIndex.
	breakIndex := nil.

	(self fits: line) ifTrue: [^ false].  "line already fits"

	(i := line indexOf: Character cr) ~= 0 ifTrue: [
		(self fits: (line copyFrom: 1 to: i - 1))
			ifTrue: [breakIndex := i]].

	breakIndex ifNil: [
		i := line indexOfSeparatorStartingAt: 1.
		[i <= line size] whileTrue: [
			(self fits: (line copyFrom: 1 to: i - 1))
				ifTrue: [
					breakIndex := i.
					i := line indexOfSeparatorStartingAt: i + 1]
				ifFalse: [i := line size + 1]]].

	breakIndex ifNil: [
		i := line size.
		[i > 1 and:
		 [(self fits: (line copyFrom: 1 to: i)) not]]
			whileTrue: [i := i - 1].
		breakIndex := i].

	lineUpToBreak := line copyFrom: 1 to: breakIndex.
	lineAfterBreak := line copyFrom: breakIndex + 1 to: line size.

	lineIndex = lines size ifTrue: [lines := lines copyWith: self emptyLine].  "make sure there is a next line"
	lines at: lineIndex put: lineUpToBreak.
	lines at: lineIndex + 1 put: lineAfterBreak, (lines at: lineIndex + 1).

	^ true
