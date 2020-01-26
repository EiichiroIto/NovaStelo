baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FromScratch';
				package: 'Stelo' with: [ spec requires: #('FromScratch') ] ]