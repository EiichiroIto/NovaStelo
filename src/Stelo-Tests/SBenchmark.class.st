Class {
	#name : #SBenchmark,
	#superclass : #Object,
	#category : #'Stelo-Tests'
}

{ #category : #accessing }
SBenchmark >> diffuse2: anInteger [
	"SBenchmark new diffuse2: 1000."
	" 163 201"

	| a d |
	Smalltalk garbageCollect.
	a := FloatArray new: 10000.
	a at: 50 put: 5000.
	d := SNativeDiffuser2 new.
	^ Time
		millisecondsToRun: [ anInteger
				timesRepeat: [ d
						diffuse8: a
						cols: 100
						rows: 100
						percent: 80.0 ] ]
]

{ #category : #accessing }
SBenchmark >> diffuse: anInteger [
	"SBenchmark new diffuse: 1000."
	" 11356 10449 10275 10207"

	| a d |
	a := FloatArray new: 10000.
	a at: 50 put: 5000.
	d := SNativeDiffuser new.
	^ Time
		millisecondsToRun: [ anInteger
				timesRepeat: [ d
						diffuse8: a
						cols: 100
						rows: 100
						percent: 80.0 ] ]
]

{ #category : #accessing }
SBenchmark >> diffuseAndMultiply: anInteger [
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
]

{ #category : #accessing }
SBenchmark >> forwardAndTurn: anInteger [
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
]
