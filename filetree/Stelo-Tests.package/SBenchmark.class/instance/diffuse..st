accessing
diffuse: anInteger
	"SBenchmark new diffuse: 1000."
	" 10449 10275 10207"

	| a d |
	a := FloatArray new: 10000.
	a at: 50 put: 5000.
	d := SDiffuser2 new.
	^ Time
		millisecondsToRun: [ anInteger
				timesRepeat: [ d
						diffuse: a
						order: 100
						percent: 80.0
						neighborSize: 8 ] ]