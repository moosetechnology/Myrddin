Class {
	#name : #MYTableRelationsVisualization,
	#superclass : #TLVisualization,
	#instVars : [
		'entities'
	],
	#category : #'Myrddin-Visualization'
}

{ #category : #'as yet unclassified' }
MYTableRelationsVisualization class >> model: aModel [
	self new entities: aModel allTables; open
]

{ #category : #'as yet unclassified' }
MYTableRelationsVisualization >> buildVisualization [
	self edgeBuilder: TLEdgeOrthogonalLineBuilder new.
	self styleSheet backgroundColor: Color veryVeryLightGray; childrenProperty: #columns; 
		childrenLayout: (RTVerticalLineLayout new gapSize: 0); 
		compositeExpandedByDefault: true.
	
	(self styleSheet > #compositeNode > #children) textColor: Color veryDarkGray; backgroundColor: Color veryVeryLightGray; borderWidth: 0; width: 300 "; onlyLabelForNodes".
	
	(self styleSheet > #compositeNode) textColor: Color white; backgroundColor: Color veryDarkGray.
	(self styleSheet > #node) textColor: Color red.
		
	self addNodesFromEntities: self entities.
	self styleSheet nodeLabel: #name.
	self layout: (RTGridLayout new gapSize: 100).
	self allChildrenNodes connectFollowingProperty: #dependentColumns.
	"(self > #compositeNode > #children)	connectFollowingProperty: #dependentColumns."
	"self connectFollowingProperty: #dependentTables."
	self addInteraction: TLNodeBasicInteraction draggable.
	self title: 'Database schema'
	
	

	
]

{ #category : #accessing }
MYTableRelationsVisualization >> entities [
	^ entities
]

{ #category : #accessing }
MYTableRelationsVisualization >> entities: anObject [
	entities := anObject
]
