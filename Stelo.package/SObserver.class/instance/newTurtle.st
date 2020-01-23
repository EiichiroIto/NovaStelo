accessing
newTurtle
	| bid breed |
	bid := breedId newNo.
	breed := STurtles new breedNo: bid.
	^ breed