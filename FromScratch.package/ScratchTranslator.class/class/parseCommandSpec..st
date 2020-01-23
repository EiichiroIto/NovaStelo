import/export
parseCommandSpec: aCommandSpec
	"Answer an array of token strings containing my keywords and argument specs."
	"self parseCommandSpec: '%a of %m'"

	| result len i j spec |
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
					ifTrue: [result addLast: (spec copyFrom: j to: j + 1)]
					ifFalse: [result addLast: '%'].
				i := j + 2]
			ifFalse: [
				result addLast: (spec copyFrom: i to: len).
				i := len + 1]].

	^ result asArray collect: [:s | s trimBoth]