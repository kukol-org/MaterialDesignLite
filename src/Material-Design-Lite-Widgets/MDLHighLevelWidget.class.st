"
I represent an abstract class for high level widgets.

Interesting point is that I have properties through a Dictionary which allow me to add some behaviours. My properties should have a selector as key and an array of parameters as value.
"
Class {
	#name : 'MDLHighLevelWidget',
	#superclass : 'MDLWidget',
	#instVars : [
		'properties'
	],
	#category : 'Material-Design-Lite-Widgets',
	#package : 'Material-Design-Lite-Widgets'
}

{ #category : 'accessing' }
MDLHighLevelWidget >> addProperties: aDictionary [
	properties addAll: aDictionary
]

{ #category : 'actions' }
MDLHighLevelWidget >> addPropertiesToBrush: aBrush [
	self properties keysAndValuesDo: [ :aSymbol :arguments | aBrush perform: aSymbol withArguments: arguments ]
]

{ #category : 'accessing' }
MDLHighLevelWidget >> class: aString [

	| currentClasses newClasses uniqueClasses |
	aString isEmptyOrNil ifTrue: [ ^ self ].

	newClasses := aString findTokens: ' '.

	currentClasses := self
		                  propertiesAt: #class:
		                  ifPresent: [ :array |
				                  array isEmpty
					                  ifTrue: [ #(  ) ]
					                  ifFalse: [ array anyOne findTokens: ' ' ] ]
		                  ifAbsent: [ #(  ) ].

	"Collect unique classes while preserving order"
	uniqueClasses := OrderedCollection new.
	currentClasses , newClasses do: [ :each |
		(uniqueClasses includes: each) ifFalse: [ uniqueClasses add: each ] ].

	self propertiesAt: #class: put: (Array with: (' ' join: uniqueClasses))
]

{ #category : 'accessing' }
MDLHighLevelWidget >> htmlClass [
	"htmlClass because it can cause problems to have a #class method in objects."

	^ self propertiesAt: #class: ifPresent: [ :array | array anyOne ] ifAbsent: [ nil ]
]

{ #category : 'accessing' }
MDLHighLevelWidget >> htmlStyle [

	^ self propertiesAt: #style: ifPresent: [ :array | array anyOne ] ifAbsent: [ nil ]
]

{ #category : 'accessing' }
MDLHighLevelWidget >> id [
	^ self propertiesAt: #id: ifPresent: [ :array | array anyOne ] ifAbsent: [ nil ]
]

{ #category : 'accessing' }
MDLHighLevelWidget >> id: aString [
	self propertiesAt: #id: put: (Array with: aString)
]

{ #category : 'initialization' }
MDLHighLevelWidget >> initialize [
	super initialize.
	properties := OrderedDictionary new
]

{ #category : 'accessing' }
MDLHighLevelWidget >> onClick: anObject [
	self propertiesAt: #onClick: put: (Array with: anObject)
]

{ #category : 'accessing' }
MDLHighLevelWidget >> properties [
	^ properties
]

{ #category : 'accessing' }
MDLHighLevelWidget >> propertiesAt: aString [
	^ self properties at: aString
]

{ #category : 'accessing' }
MDLHighLevelWidget >> propertiesAt: aString ifAbsent: aBlock [
	^ self properties at: aString ifAbsent: aBlock
]

{ #category : 'accessing' }
MDLHighLevelWidget >> propertiesAt: aString ifPresent: aBlock ifAbsent: anotherBlock [
	^ self properties at: aString ifPresent: aBlock ifAbsent: anotherBlock
]

{ #category : 'accessing' }
MDLHighLevelWidget >> propertiesAt: aString put: anArray [

	^ self properties at: aString put: anArray
]

{ #category : 'accessing' }
MDLHighLevelWidget >> style: aString [

	| currentRules newRules uniqueRules |
	aString isEmptyOrNil ifTrue: [ ^ self ].

	newRules := (aString findTokens: ';')
		            collect: [ :each | each trimBoth ]
		            thenReject: #isEmpty.

	currentRules := self
		                propertiesAt: #style:
		                ifPresent: [ :array |
				                array isEmpty
					                ifTrue: [ #(  ) ]
					                ifFalse: [
					                (array anyOne findTokens: ';')
						                collect: [ :each | each trimBoth ]
						                thenReject: #isEmpty ] ]
		                ifAbsent: [ #(  ) ].

	"Collect unique CSS rules while preserving order"
	uniqueRules := OrderedCollection new.
	currentRules , newRules do: [ :each |
		(uniqueRules includes: each) ifFalse: [ uniqueRules add: each ] ].

	self propertiesAt: #style: put: (Array with: ('; ' join: uniqueRules))
]
