initialization
initializeDialogWindow: aDialog
	super initializeDialogWindow: aDialog.
	aDialog closeOnBackdropClick: false;
	askOkToClose: true