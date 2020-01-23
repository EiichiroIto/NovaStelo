accessing
plot: anInteger list: aCollection
	self ensurePenExists: anInteger.
	data size > aCollection size
		ifTrue: [ aCollection
				withIndexDo: [ :each :index | self replacePlot: anInteger at: index put: each ].
			aCollection size + 1 to: data size do: [ :index | self replacePlot: anInteger at: index put: nil ].
			last at: anInteger put: nil ]
		ifFalse: [ 1 to: data size do:
				[ :index | self replacePlot: anInteger at: index put: (aCollection at: index) ].
			data size + 1 to: aCollection size do: [ :index | 
				self newData.
				last at: anInteger put: (aCollection at: index) ] ].
	self updateDisplay