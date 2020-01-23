private
turtleBreedsDo: aBlock
	SBreedId defaultUserNo to: breeds size do: [ :each | 
		| turtle |
		turtle := self breedOf: each.
		turtle ifNotNil: [ aBlock value: turtle ] ]