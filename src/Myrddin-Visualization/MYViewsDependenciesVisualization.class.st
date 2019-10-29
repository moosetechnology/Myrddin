Class {
	#name : #MYViewsDependenciesVisualization,
	#superclass : #TLVisualization,
	#instVars : [
		'entities'
	],
	#category : #'Myrddin-Visualization'
}

{ #category : #'class initialization' }
MYViewsDependenciesVisualization class >> model: aMooseModel [
	self new entities: (Myrddin getInstance model entities select: [ :e | e isView ]); display
	

]

{ #category : #action }
MYViewsDependenciesVisualization >> buildVisualization [

	self edgeBuilder color: Color lightGray.

	self > #tables
		addNodesFromEntities: (self entities select: [ :e | e isTable ]);
		connectFollowingProperty: [ :aTable | 
			(aTable queryAllOutgoing) atScope:FAMIXTable].
		
	(self > #tables)	addInteraction: TLNodeBasicInteraction popup;
		addInteraction: TLNodeBasicInteraction draggable;
		layout: RTTreeLayout.(self > #tables) styleSheet nodeLabel: [:e | e name asString] position: #top ; width: [ :e | ((e queryOutgoing: FAMIXColumnToColumnAssociation) atScope: FAMIXTable) size * 10 max: 5 ]; height: [ :e | ((e queryIncoming: FAMIXColumnToColumnAssociation) atScope: FAMIXTable) size *10 max: 5 ].
		(self > #tables) styleSheet backgroundColor: [ :entity | entity isView ifTrue: [ Color green ] ifFalse: [Color red]];
		textColor:Color black.

		
 
]

{ #category : #action }
MYViewsDependenciesVisualization >> display [
	self open


]

{ #category : #accessing }
MYViewsDependenciesVisualization >> entities [
	^ entities
]

{ #category : #accessing }
MYViewsDependenciesVisualization >> entities: anObject [
	entities := anObject
]
