Class {
	#name : 'BaselineOfNovaStelo',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfNovaStelo',
	#package : 'BaselineOfNovaStelo'
}

{ #category : 'baselines' }
BaselineOfNovaStelo >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'FromScratch';
			package: 'FromScratch-Tests'
			with: [ spec requires: #( 'FromScratch' ) ];
			package: 'Microworld' with: [ spec requires: #( 'FromScratch' ) ];
			package: 'Stelo' with: [ spec requires: #( 'Microworld' ) ];
			package: 'Stelo-Tests' with: [ spec requires: #( 'Stelo' ) ] ].
	spec group: 'Deploy' with: #( 'Stelo' )
]

{ #category : 'accessing' }
BaselineOfNovaStelo >> projectClass [
	^ MetacelloCypressBaselineProject
]
