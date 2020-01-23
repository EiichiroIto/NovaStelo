private
updateTable
	tableVars
		items: (getValuesBlock ifNotNil: [ getValuesBlock value ] ifNil: [ #() ])