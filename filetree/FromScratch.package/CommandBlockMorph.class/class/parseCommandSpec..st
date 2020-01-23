utilities
parseCommandSpec: aCommandSpec
	"Answer an array of token strings containing my keywords and argument specs."

	| result len i j spec k |
	result := OrderedCollection new.
	spec := aCommandSpec.
	"(spec isKindOf: UTF8) ifTrue: [spec := String withAll: spec]."
	len := aCommandSpec size.

	i := 1.
	[(i < len) and: [(spec at: i) isSeparator]] whileTrue: [i := i + 1].
	[i <= len] whileTrue: [
		j := spec indexOf: $% startingAt: i.
		j > 0
			ifTrue: [
				j > i ifTrue: [result addLast: (spec copyFrom: i to: j - 1)].
				j < len
					ifTrue: [k := j + 1.
						((spec at: k) isLetter)
							ifTrue: [[(k+1 <= len) and: [(spec at: k+1) isDigit]] whileTrue:[
								k := k + 1].
								(k >= len)
									ifTrue: [result addLast: (spec copyFrom: j to: len).
										i := len + 1]
									ifFalse: [result addLast: (spec copyFrom: j to: k).
										i := k+1]]
							ifFalse: [result addLast: '%'.
										i := j + 1]]
					ifFalse: [result addLast: '%'.
						i := j + 2]]
			ifFalse: [
				result addLast: (spec copyFrom: i to: len).
				i := len + 1]].

	result := result select: [:s | s ~= ' '].
	^ result asArray collect: [:s | s trimBoth]
