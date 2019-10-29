"
A MYCrLfItemReport is a simple element that contains a carriage return.
"
Class {
	#name : #MYCrLfItemReport,
	#superclass : #Object,
	#category : #'Myrddin-Report'
}

{ #category : #action }
MYCrLfItemReport >> asString [
	^String crlf
]
