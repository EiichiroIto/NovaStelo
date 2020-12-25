accessing
diffuseAndMultiply: anInteger
	"SBenchmark new diffuseAndMultiply: 100000. --> "

	"SBenchmark new diffuseAndMultiply: 1000. --> 16237"

	"SBenchmark new diffuseAndMultiply: 1000. --> 9770"

	"SBenchmark new diffuseAndMultiply: 1000. --> 9229"

	"SBenchmark new diffuseAndMultiply: 1000. --> 14574"

	"SBenchmark new diffuseAndMultiply: 1000. --> 9254"

	"SBenchmark new diffuseAndMultiply: 1000. 15080"

	"SBenchmark new diffuseAndMultiply: 1000. 15398"

	"SBenchmark new diffuseAndMultiply: 1000. 16743"

	"SBenchmark new diffuseAndMultiply: 1000. 9618"

	"SBenchmark new diffuseAndMultiply: 1000. 11163"

	"SBenchmark new diffuseAndMultiply: 1000. 11057"

	"SBenchmark new diffuseAndMultiply: 1000. 8669"

	"SBenchmark new diffuseAndMultiply: 1000. 10050 "

	| w p pr ret v |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w createPatch: 100.
	v := w patches addVariable: 'a'.
	w var: v breed: SBreedId patchBreedNo putAll: 100.
	pr := SProgram new.
	pr
		addCode:
			{v.
			20.
			#diffuse.
			v.
			0.95.
			#multiplyBy}.
	pr
		addEntryPoint: 1
		eventNo: EventId loopEventNo
		breedNo: SBreedId observerBreedNo.
	p := w newProcess program: pr.
	p loop.
	Smalltalk garbageCollect.
	ret := Time millisecondsToRun: [ anInteger timesRepeat: [ p step ] ].
	^ ret