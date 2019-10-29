Class {
	#name : #MYEntityDynamicDependenciesVisualization,
	#superclass : #TLTreeExplorer,
	#instVars : [
		'famixType',
		'model'
	],
	#category : #'Myrddin-Visualization'
}

{ #category : #'as yet unclassified' }
MYEntityDynamicDependenciesVisualization class >> model: aMooseModel entityType: aFamixType [
	| entities selection |
	entities := (aMooseModel entities select: [ :e | (e class = aFamixType) ]) collect: [ :e | e name ].
	selection := UIManager default enterOrRequestFrom: entities title: 'Please select the entity name'.
	selection ifNotNil: [ self new root: selection; property: #dependentEntities; famixType: aFamixType ; display ]
]

{ #category : #building }
MYEntityDynamicDependenciesVisualization >> buildVisualization [
	self flag: 'add legend'.
	self addInteraction: ((TLCustomAction block: [ :node | node inspect] ) onClick ).
	"self leftEntities: [ :entity |  entity userEntities  ] .
	self rightEntities: [ :entity | entity dependentEntities ]."
	self styleSheet shape: TLRectangle; backgroundColor: [ :entity | entity isView ifTrue: [ Color red ] ifFalse: [ entity isTrigger ifTrue: [Color blue] ifFalse: [ entity isStoredProcedure ifTrue: [ Color yellow ] ifFalse: [ entity isTable ifTrue: [Color lightRed] ifFalse: [ Color white ] ] ] ] ].
	self styleSheet textColor: Color black.
	
	super buildVisualization .
	"self legend: (TLLegend on: self nodes label: [ :e | e entity class asString ] )".
]

{ #category : #'*Myrddin-Core' }
MYEntityDynamicDependenciesVisualization >> display [

self root: (Myrddin getInstance model entities detect: [ :e | (e class = self famixType)  and: [ e name = self root ] ]); open
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> entity [
	^ self mainEntity 
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> entity: anEntity [
	self mainEntity: anEntity
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> famixType [
	^ famixType
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> famixType: anObject [
	famixType := anObject
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> model [
	^ model
]

{ #category : #accessing }
MYEntityDynamicDependenciesVisualization >> model: anObject [
	model := anObject
]
