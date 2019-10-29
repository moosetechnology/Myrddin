Extension { #name : #MYViewsDependenciesVisualization }

{ #category : #'*Myrddin-Core' }
MYViewsDependenciesVisualization class >> model: aMooseModel [
	self new entities: (Myrddin getInstance model entities select: [ :e | e isView ]); display
	

]
