"
A MYBrowser is a abstract browser.
"
Class {
	#name : #MYBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Myrddin-Browsers'
}

{ #category : #opening }
MYBrowser class >> open [
	^self new
]

{ #category : #action }
MYBrowser >> entitiesWithType: constructor [

	constructor list
		display: [ :typeName | (self listOfFamixEntityWithType: typeName)  ];
		format: #asString
]

{ #category : #action }
MYBrowser >> famixEntities [
	^Myrddin getInstance model entities
]

{ #category : #action }
MYBrowser >> famixTypeName: aEntity [
	^aEntity class mooseDescription name
]

{ #category : #action }
MYBrowser >> famixTypesIn: constructor [
	
	constructor list
		display: [ :organizer | self listOfFamixEntityTypes sorted ];
		format: #asString
]

{ #category : #initialize }
MYBrowser >> initialize [
	super initialize.
	"browser := GLMTabulator new.
	browser 
		column: #packages;
		column: #classes.
		
	browser transmit to: #packages; andShow: [ :a | self packagesIn: a ].
	browser transmit from: #packages; to: #classes; andShow: [ :a | self classesIn: a ].
	
	browser openOn: self organizer"
]

{ #category : #action }
MYBrowser >> listOfFamixEntityTypes [
	^ ((self famixEntities collect: [ :e | self famixTypeName: e ]) asSet) asOrderedCollection sort: [ :a :b | a < b ]
	
	
]

{ #category : #action }
MYBrowser >> listOfFamixEntityWithType: aType [
	^(self famixEntities select: [ :e | (self famixTypeName: e) = aType ]) sorted 
]
