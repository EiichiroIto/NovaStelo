private
delete
	super delete.
	whenDeletedDo ifNotNil: [ whenDeletedDo value ]