microworld
clear
	"clear means clear all variable values with keeping its definition"
	variables ifNil: [ ^ self ].
	variables clear.
	"self halt.
	variables updateVarDef: varId"