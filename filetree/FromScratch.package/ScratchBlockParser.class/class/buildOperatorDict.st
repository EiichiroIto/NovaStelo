private
buildOperatorDict
	"self buildOperatorDict"
	OperatorDict := Dictionary new.
	OperatorDict at: #+ put: #plus:and:.
	OperatorDict at: #- put: #minus:with:.
	OperatorDict at: #* put: #multiply:and:.
	OperatorDict at: #/ put: #divide:by:.
	OperatorDict at: #< put: #less:than:.
	OperatorDict at: #= put: #equal:to:.
	OperatorDict at: #> put: #more:than:.
	OperatorDict at: #& put: #and:with:.
	OperatorDict at: #| put: #or:with:.
	OperatorDict at: #\\ put: #mod:by:.
	InvOperatorDict := Dictionary new.
	OperatorDict
		keysAndValuesDo: [ :key :value | InvOperatorDict at: value asSymbol put: key asString ]