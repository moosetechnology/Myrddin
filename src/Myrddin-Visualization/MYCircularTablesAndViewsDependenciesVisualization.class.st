"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State the name of the class with one line description: For example, I'm xxx the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	columns:		<Object>
	entities:		<Object>
	tables:		<Object>


    Implementation Points
"
Class {
	#name : #MYCircularTablesAndViewsDependenciesVisualization,
	#superclass : #TLVisualization,
	#instVars : [
		'entities'
	],
	#category : #'Myrddin-Visualization'
}

{ #category : #'class initialization' }
MYCircularTablesAndViewsDependenciesVisualization class >> model: aMooseModel [
	self new entities: (aMooseModel entities select: [ :e | (e isTable or: [ e isView ]) ]); display
	

]

{ #category : #action }
MYCircularTablesAndViewsDependenciesVisualization >> buildVisualization [
	(self > #tables)
		addNodesFromEntities: (self entities select: [ :e | e isColumnsContainer ]);
		connectFollowingProperty: [ :aTable | aTable queryAllOutgoing atScope: FmxSQLTable ].
	(self > #tables)
		addInteraction: TLPopUpAction onMouseOver;
		layout: TLCircularLayout.
	(self > #tables) styleSheet
		nodeLabel: [ :e | e name asString ] position: #top;
		width:
				[ :e | (e queryAllOutgoing atScope: FmxSQLColumnsContainer) size * 10 max: 5 ];
		height:
				[ :e | (e queryAllIncoming atScope: FmxSQLColumnsContainer) size * 10 max: 5 ].
	(self > #tables) styleSheet
		backgroundColor: [ :entity | 
			entity isView
				ifTrue: [ Color green ]
				ifFalse: [ Color red ] ];
		textColor: Color black
]

{ #category : #action }
MYCircularTablesAndViewsDependenciesVisualization >> display [
	self open


]

{ #category : #accessing }
MYCircularTablesAndViewsDependenciesVisualization >> entities [
	^ entities
]

{ #category : #accessing }
MYCircularTablesAndViewsDependenciesVisualization >> entities: anObject [
	entities := anObject
]
