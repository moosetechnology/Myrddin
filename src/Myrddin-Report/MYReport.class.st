"
A MYItemReport is a Myrddin report.
"
Class {
	#name : #MYReport,
	#superclass : #OrderedCollection,
	#instVars : [
		'title'
	],
	#category : #'Myrddin-Report'
}

{ #category : #'class initialization' }
MYReport class >> title: aTitle [
	^self new addTitle: aTitle
		
]

{ #category : #action }
MYReport >> addTitle: aTitle [
	self title: aTitle.
	self
		add: (MYSingleItemReport value: aTitle); 
		add: (MYCrLfItemReport new)
]

{ #category : #action }
MYReport >> produce [
	| report |
	
	report := WriteStream on: String new.
	self do: [ :item | report nextPutAll: item asString ].
	^report contents
]

{ #category : #accessing }
MYReport >> title [
	^ title
]

{ #category : #accessing }
MYReport >> title: anObject [
	title := anObject
]
