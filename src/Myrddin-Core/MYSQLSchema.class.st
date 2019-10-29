"
a MYSQLSchema contains the filename and the SQL code.
"
Class {
	#name : #MYSQLSchema,
	#superclass : #Object,
	#instVars : [
		'filename',
		'code'
	],
	#category : #'Myrddin-Core'
}

{ #category : #'class initialization' }
MYSQLSchema class >> filename: aFilename code: aSQLSchema [
	^self new filename: aFilename; code: aSQLSchema
]

{ #category : #accessing }
MYSQLSchema >> code [
	^ code
]

{ #category : #accessing }
MYSQLSchema >> code: anObject [
	code := anObject
]

{ #category : #accessing }
MYSQLSchema >> filename [
	^ filename
]

{ #category : #accessing }
MYSQLSchema >> filename: anObject [
	filename := anObject
]
