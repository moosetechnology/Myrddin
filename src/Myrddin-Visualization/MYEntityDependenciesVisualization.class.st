Class {
	#name : #MYEntityDependenciesVisualization,
	#superclass : #TLButterfly,
	#instVars : [
		'famixType',
		'model'
	],
	#category : #'Myrddin-Visualization'
}

{ #category : #'as yet unclassified' }
MYEntityDependenciesVisualization class >> model: aMooseModel entityType: aFamixType [
	| entities selection |
	entities := ((aMooseModel entities select: [ :e | (e isStub not and: [e class = aFamixType]) ]) collect: [ :e | e name ]) sort: [ :a :b | a < b ] .
	selection := UIManager default enterOrRequestFrom: entities title: 'Please select the entity name'.
	selection ifNotNil: [  self new entity: selection; famixType: aFamixType ; model: aMooseModel ; display ]
]

{ #category : #building }
MYEntityDependenciesVisualization >> buildVisualization [

	"self addInteraction: TLNodeBasicInteraction draggable."
	self addInteraction: ((TLCustomAction block: [ :node | node inspect] ) onClick ).
	self leftEntities: [ :entity | entity userEntities asOrderedCollection sort: [ :a :b | a className < b className or: [ a className = b className and: [a name < b name] ] ] ] .
	self rightEntities: [ :entity | entity dependentEntities asOrderedCollection sort: [ :a :b | a className < b className or: [ a className = b className and: [a name < b name] ] ] ].
	self styleSheet nodeLabelPosition: #top; backgroundColor: [ :entity | entity isView ifTrue: [ Color red ] ifFalse: [ entity isTrigger ifTrue: [Color blue] ifFalse: [ entity isStoredProcedure ifTrue: [ Color yellow ] ifFalse: [ entity isTable ifTrue: [Color lightRed] ifFalse: [ Color white ] ] ] ] ].
	self styleSheet textColor: Color black.
	
	super buildVisualization .
	"self legend: (TLLegend on: self allNodes label: [ :e | e entity class asString ] )."
]

{ #category : #display }
MYEntityDependenciesVisualization >> display [
self mainEntity: (self model entities detect: [ :e | (e class = self famixType)  and: [ e name = self entity ] ]); open
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> entity [
	^ self mainEntity 
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> entity: anEntity [
	self mainEntity: anEntity
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> famixType [
	^ famixType
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> famixType: anObject [
	famixType := anObject
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> model [
	^ model
]

{ #category : #accessing }
MYEntityDependenciesVisualization >> model: anObject [
	model := anObject
]
