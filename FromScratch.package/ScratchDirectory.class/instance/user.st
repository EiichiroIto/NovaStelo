private
user
	^ homeDirectory ifNil: [ self documents ]