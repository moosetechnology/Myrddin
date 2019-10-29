"
A MYInformation is a report that's describes the database.
"
Class {
	#name : #MYInformations,
	#superclass : #Object,
	#instVars : [
		'schema',
		'model'
	],
	#category : #'Myrddin-Core'
}

{ #category : #'class initialization' }
MYInformations class >> schema: aSchema model: aModel [
	^self new schema: aSchema; model: aModel; build; open
]

{ #category : #action }
MYInformations >> build [
	| report |
	report := MYReport title: self model name.
	report add: (MYKeyValueItemReport key: 'Number of tables' value: self numberOfTables). 
	report add: (MYKeyValueItemReport key: 'Number of Views' value: self numberOfViews). 
	report add: (MYKeyValueItemReport key: 'Number of columns' value: self numberOfColumns).
	report add: (MYKeyValueItemReport key: 'Number of Triggers' value: self numberOfTriggers). 
	report add: (MYKeyValueItemReport key: 'Number of functions' value: self numberOfFunctions).
	^report produce
]

{ #category : #accessing }
MYInformations >> model [
	^ model
]

{ #category : #accessing }
MYInformations >> model: anObject [
	model := anObject
]

{ #category : #action }
MYInformations >> numberOfColumns [
	^(self model entities reject: #isStub) count: [ :e | e isColumn ]
]

{ #category : #action }
MYInformations >> numberOfFunctions [
	^(self model entities reject: #isStub) count: [ :e | e isStoredProcedure ]
]

{ #category : #action }
MYInformations >> numberOfTables [
	^(self model entities reject: #isStub) count: [ :e | e isTable ]
]

{ #category : #action }
MYInformations >> numberOfTriggers [
	^(self model entities reject: #isStub) count: [ :e | e isTrigger ]
]

{ #category : #action }
MYInformations >> numberOfViews [
	^(self model entities reject: #isStub) count: [ :e | e isView ]
]

{ #category : #action }
MYInformations >> open [
	UIManager default edit: (self build) label: 'Informations'
]

{ #category : #accessing }
MYInformations >> schema [
	^ schema
]

{ #category : #accessing }
MYInformations >> schema: anObject [
	schema := anObject
]
