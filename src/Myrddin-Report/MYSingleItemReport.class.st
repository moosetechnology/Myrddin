"
a MYSingleItemReport contains only one text.
"
Class {
	#name : #MYSingleItemReport,
	#superclass : #MYCrLfItemReport,
	#instVars : [
		'value'
	],
	#category : #'Myrddin-Report'
}

{ #category : #'class initialization' }
MYSingleItemReport class >> value: aValue [
	^self new value: aValue
]

{ #category : #action }
MYSingleItemReport >> asString [
	^self value , String crlf
]

{ #category : #accessing }
MYSingleItemReport >> value [
	^ value
]

{ #category : #accessing }
MYSingleItemReport >> value: anObject [
	value := anObject asString
]
