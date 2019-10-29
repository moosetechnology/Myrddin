"
A MYEntitiesBrowser is a browser for SQL entities.
"
Class {
	#name : #MYEntitiesBrowser,
	#superclass : #MYBrowser,
	#category : #'Myrddin-Browsers'
}

{ #category : #action }
MYEntitiesBrowser >> listOfFamixEntityTypes [
	
	^ super listOfFamixEntityTypes intersection: self selectedTypes 
]

{ #category : #configuration }
MYEntitiesBrowser >> selectedTypes [
	^#('Column' 'View' 'SQLFunction' 'Table' 'Trigger')
]
