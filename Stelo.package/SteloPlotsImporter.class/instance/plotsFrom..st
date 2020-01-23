private
plotsFrom: aString
	| result |
	result := Array new.
	aString
		linesDo: [ :line | 
			(line splitOn: $,)
				withIndexDo: [ :each :index | 
					index > result size
						ifTrue: [ result := result grownBy: index - result size.
							result at: index put: OrderedCollection new ].
					each isEmpty
						ifFalse: [ (result at: index) add: each asNumberNoError ] ] ].
	^ result