accessing
forwardAndTurn: anInteger
	"SBenchmark new forwardAndTurn: 10000. --> 25618"

	"SBenchmark new forwardAndTurn: 10000. --> 28503"

	"SBenchmark new forwardAndTurn: 10000. --> 2679"

	"SBenchmark new forwardAndTurn: 100000. --> 30937"

	"SBenchmark new forwardAndTurn: 100000. --> 30463"

	"SBenchmark new forwardAndTurn: 100000. --> 28387"

	"SBenchmark new forwardAndTurn: 100000. 74578"

	"SBenchmark new forwardAndTurn: 100000. 61745"

	"SBenchmark new forwardAndTurn: 100000. 66739"

	"SBenchmark new forwardAndTurn: 100000. 98973"

	"SBenchmark new forwardAndTurn: 100000. 103008"

	"SBenchmark new forwardAndTurn: 100000. 111147"

	"SBenchmark new forwardAndTurn: 100000. 61259"

	"SBenchmark new forwardAndTurn: 100000. 60514"

	"SBenchmark new forwardAndTurn: 100000. 56667"

	"SBenchmark new forwardAndTurn: 100000. 55183"

	"SBenchmark new forwardAndTurn: 100000. 38644"

	"SBenchmark new forwardAndTurn: 100000. 46125"

	"SBenchmark new forwardAndTurn: 100000. 44769 "

	"SBenchmark new forwardAndTurn: 100000. 32495"

	"SBenchmark new forwardAndTurn: 100000. 31757 "
	"SBenchmark new forwardAndTurn: 100000. "
	"42847 33955 30555 28312 "

	| w p pr ret |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w addBreed: (STurtles new breedNo: 3).
	w
		createPatch: 100;
		create: 3 turtles: anInteger.
	pr := SProgram new.
	pr addCode: #(#pushShort 10 0 #forward #pushShort 15 0 #pushShort 5 0 #getVar #plus #setHeading #stop).
	pr addEntryPoint: 1 eventNo: EventId loopEventNo breedNo: 3.
	p := w newProcess program: pr.
	p loop.
	Smalltalk garbageCollect.
	ret := Time millisecondsToRun: [ 100 timesRepeat: [ p step ] ].
	^ ret