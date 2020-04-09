private
dataMenu
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Save Stage as PNG';
						action: [ application saveStageAsImage ] ];
				addItem: [ :item | 
					item
						name: [ application isRecording
								ifTrue: [ 'Stop Stage Recording' ]
								ifFalse: [ 'Start Stage Recording' ] ];
						autoRefresh: true;
						action: [ application toggleStageRecording ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Plots Data to Observer List';
						action: [ application copyPlotsToList ] ];
				addItem: [ :item | 
					item
						name: 'Observer List to Plots Data';
						action: [ application copyListToPlots ] ] ];
		yourself