Extension { #name : #FmxSQLColumn }

{ #category : #'*Myrddin-Core' }
FmxSQLColumn >> <= aFamixColumn [
	^ self className = aFamixColumn className
		ifTrue: [ (self columnsContainer name = aFamixColumn columnsContainer name) ifTrue: [self name <= aFamixColumn name] ifFalse: [self columnsContainer <= aFamixColumn columnsContainer]]
		ifFalse: [ self className <= aFamixColumn className ]
]
