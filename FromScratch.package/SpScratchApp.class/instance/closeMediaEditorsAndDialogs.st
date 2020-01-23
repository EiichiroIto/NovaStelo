private
closeMediaEditorsAndDialogs
	SpDialogWindow allInstances do: #cancel.
	DialogWindow allInstances do: #cancel.
	^ true