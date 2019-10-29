Extension { #name : #FmxSQLNamedEntity }

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> <= aFmxNamedEntity [ 
	^self className = aFmxNamedEntity className
	ifTrue: [ self name <= aFmxNamedEntity name ]
	ifFalse: [ self className <= aFmxNamedEntity className ]
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> dependentEntities [
	^ (self dependentTables, self dependentFunctions, self dependentViews, self dependentTriggers) asSet 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> dependentFunctions [
<navigation: #dependentFunctions>
	^self
		lookUpPropertyNamed: #dependentFunctions
		computedAs:[(self queryAllOutgoing atScope: FmxSQLStoredProcedure) withoutSelfLoops asSet asOrderedCollection]
	 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> dependentTables [
<navigation: #dependentTables>
	^self
		lookUpPropertyNamed: #dependentTables
		computedAs:[((self queryAllOutgoing ) atScope: FmxSQLTable) withoutSelfLoops asSet asOrderedCollection]
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> dependentTriggers [
	<navigation: #dependentTriggers>
	^self
		lookUpPropertyNamed: #dependentTriggers
		computedAs:[(self queryAllOutgoing  atScope: FmxSQLTrigger) withoutSelfLoops asSet asOrderedCollection]
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> dependentViews [
<navigation: #dependentViews>
	^self
		lookUpPropertyNamed: #dependentViews
		computedAs:[(self queryAllOutgoing  atScope: FmxSQLView) withoutSelfLoops asSet asOrderedCollection]
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> userEntities [
	^ (self userTables , self userFunctions , self userTriggers , self userViews  ) asSet.
	 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> userFunctions [
<navigation: #userFunctions>
	^self
		lookUpPropertyNamed: #userFunctions
		computedAs:[(self queryAllIncoming atScope: FmxSQLStoredProcedure) withoutSelfLoops asSet asOrderedCollection]
	 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> userTables [ 
<navigation: #userTables>
	^self
		lookUpPropertyNamed: #userTables
		computedAs:[((self queryAllIncoming ) atScope: FmxSQLTable) withoutSelfLoops asSet asOrderedCollection]
	 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> userTriggers [
	<navigation: #userTriggers>
	^self
		lookUpPropertyNamed: #userTriggers
		computedAs:[(self queryAllIncoming  atScope: FmxSQLTrigger) withoutSelfLoops asSet asOrderedCollection]
	 
]

{ #category : #'*Myrddin-Core' }
FmxSQLNamedEntity >> userViews [ 
<navigation: #userViews>
	^self
		lookUpPropertyNamed: #userViews
		computedAs:[(self queryAllIncoming  atScope: FmxSQLView) withoutSelfLoops asSet asOrderedCollection]
	 
]
