Extension { #name : #MYEntityDynamicDependenciesVisualization }

{ #category : #'*Myrddin-Core' }
MYEntityDynamicDependenciesVisualization >> display [

self root: (Myrddin getInstance model entities detect: [ :e | (e class = self famixType)  and: [ e name = self root ] ]); open
]
