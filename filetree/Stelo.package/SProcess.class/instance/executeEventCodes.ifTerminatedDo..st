execution
executeEventCodes: anEventCodes ifTerminatedDo: aBlock
	1 to: sworld maxBreedNo do: [ :bno | 
		| codes |
		codes := anEventCodes forBreedNo: bno.
		codes
			do: [ :code | 
				sworld
					livingBreed: bno
					do: [ :index | 
						self
							executeThread: code
							breedNo: bno
							index: index
							ifTerminatedDo: aBlock ] ] ].