private
plottingData
	| stream rest count w |
	data isEmpty
		ifTrue: [ ^ Array new ].
	stream := WriteStream on: Array new.
	w := rest := self plottingWidth.
	data size > rest
		ifTrue: [ 1 to: rest do: [ :each | 
				stream
					nextPut: (self plottingDataAt: (data size / rest * each) truncated) ] ]
		ifFalse: [ 1 to: data size do: [ :each | 
				stream nextPut: (self plottingDataAt: each).
				rest := rest - 1.
				data size > 1
					ifTrue: [ count := ((w - 1) / (data size - 1)) truncated - 1.
						(count min: rest)
							timesRepeat: [ stream nextPut: (Array new: pens size) ].
						rest := rest - count ] ].
			rest timesRepeat: [ stream nextPut: (Array new: pens size) ] ].
	^ stream contents