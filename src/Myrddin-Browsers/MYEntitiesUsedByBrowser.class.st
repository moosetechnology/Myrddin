"
a MYEntitiesUsedByBrowser is a browser that displays the entities used by another entity.
""browser 
		column: #FamixTypes;
		column: #FamixEntities.
		
	browser transmit to: #FamixTypes; andShow: [ :a | self famixTypesIn: a ].
	browser transmit from: #FamixTypes; to: #FamixEntities; andShow: [ :t | self entitiesWithType: t ].""
"
Class {
	#name : #MYEntitiesUsedByBrowser,
	#superclass : #MYEntitiesBrowser,
	#category : #'Myrddin-Browsers'
}

{ #category : #accessing }
MYEntitiesUsedByBrowser class >> title [
	^'Entities used by another entity'
]

{ #category : #'initialize-release' }
MYEntitiesUsedByBrowser >> initialize [
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
								ifFalse: [ item userEntities asOrderedCollection sorted ] ] ] ].
	browser openOn: self famixEntities
]
