private
labelsAndJumpsFor: aCollection
	| labels jumps |
	labels := Array new: labelId size.
	jumps := OrderedCollection new.
	aCollection
		do: [ :each | 
			each isLabel
				ifTrue: [ labels at: each id put: address ].
			each isJump
				ifTrue: [ jumps add: each ].
			address := address + each codeSize ].
	^ Array with: labels with: jumps asArray