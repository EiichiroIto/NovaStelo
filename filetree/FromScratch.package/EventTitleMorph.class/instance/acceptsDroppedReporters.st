queries
acceptsDroppedReporters
	"Accept reporter blocks in broadcast blocks but not in 'when I receive' hat block."

	^ owner notNil and: [ owner isCommandBlock ]