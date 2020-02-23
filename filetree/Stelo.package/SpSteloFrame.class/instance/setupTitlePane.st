initialization
setupTitlePane
	titlePane
		projectName: 'New Project';
		clearTurtlesAction: [ application clearTurtles ];
		clearPatchesAction: [ application clearPatches ];
		startSetupAction: [ application startSetup ];
		stopAllAction: [ application stopAll ];
		stepLoopAction: [ application stepLoop ];
		startLoopSlowAction: [ application startLoopSlow ];
		startLoopAction: [ application startLoop ];
		startEventAction: [ application startEvent ]