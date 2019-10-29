"
A MYEntitiesWithDependancesBrowser is a brower that display the entities that have dependencies in the model.
"
Class {
	#name : #MYEntitiesWithDependancesBrowser,
	#superclass : #MYEntitiesBrowser,
	#category : #'Myrddin-Browsers'
}

{ #category : #accessing }
MYEntitiesWithDependancesBrowser class >> title [
	^'Entities with dependencies'
]

{ #category : #initialization }
MYEntitiesWithDependancesBrowser >> initialize [
	super initialize.
	browser := GLMFinder new
		variableSizePanes;
		title: self class title;
		yourself.
	browser
		with: [ :b | 
			b
				showFirst: [ :a | self famixTypesIn: a ];
				show: [ :a | 
					a list
						display: [ :item | 
							item isString
								ifTrue: [ self listOfFamixEntityWithType: item ]
								ifFalse: [ item dependentEntities asOrderedCollection
										sort: [ :e1 :e2 | 
											e1 className = e2 className
												ifTrue: [ e1 name < e2 name ]
												ifFalse: [ e1 className < e2 className ] ] ] ] ] ].
	browser openOn: self famixEntities
]
