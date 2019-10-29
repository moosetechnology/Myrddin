Class {
	#name : #BaselineOfMyrddin,
	#superclass : #BaselineOf,
	#category : #BaselineOfMyrddin
}

{ #category : #baselines }
BaselineOfMyrddin >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'Myrddin-Browsers' with: [ spec requires: #('Myrddin-Core') ];
				package: 'Myrddin-Core' with: [ spec requires: #('DBConnectionsManager' 'FAMIXNGSQL' 'Myrddin-Browsers' 'Myrddin-Report' 'Myrddin-Visualization') ];
				package: 'Myrddin-Report';
				package: 'Myrddin-Visualization' with: [ spec requires: #('TelescopeCytoscape' 'FamixNGSQL') ].
			spec
				baseline: 'DBConnectionsManager'
				with: [ spec
						repository: 'github://juliendelplanque/DBConnectionsManager/repository';
						loads: 'pgmetadata' ].
			spec
    			baseline: 'TelescopeCytoscape'
    			with: [ spec repository: 'github://TelescopeSt/TelescopeCytoscape:v2.x.x/src' ].
			spec
				baseline: 'FAMIXNGSQL'
				with: [ spec
						repository: 'github://juliendelplanque/FamixNGSQL/repository' ] ]
]
