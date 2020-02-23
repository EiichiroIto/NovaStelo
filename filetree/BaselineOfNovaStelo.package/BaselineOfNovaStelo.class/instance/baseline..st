baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FromScratch';
				package: 'FromScratch-Tests'
					with: [ spec requires: #('FromScratch') ];
				package: 'Stelo' with: [ spec requires: #('FromScratch') ];
				package: 'Stelo-Tests'
					with: [ spec requires: #('FromScratch' 'Stelo') ] ]