"
A MYKeyTextItemReport contains one key and one text.
"
Class {
	#name : #MYKeyValueItemReport,
	#superclass : #MYSingleItemReport,
	#instVars : [
		'key'
	],
	#category : #'Myrddin-Report'
}

{ #category : #'class initialization' }
MYKeyValueItemReport class >> key: aKey value: aValue [
	^self new key: aKey; value: aValue
]

{ #category : #action }
MYKeyValueItemReport >> asString [
	^self key , ' : ' , self value , String crlf
]

{ #category : #accessing }
MYKeyValueItemReport >> key [
	^ key
]

{ #category : #accessing }
MYKeyValueItemReport >> key: anObject [
	key := anObject
]
