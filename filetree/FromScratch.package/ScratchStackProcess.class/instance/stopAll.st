api
stopAll
	topBlock applicationDo: [ :app | app stopAllProcesses ]