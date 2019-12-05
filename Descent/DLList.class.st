"
I represent a structure with a key and value and a list of pairs.

( k : v )
( k : v ( k1 : v2) ... )
"
Class {
	#name : #DLList,
	#superclass : #Object,
	#instVars : [
		'pairSequence',
		'head'
	],
	#category : #'Descent-DataStructure'
}

{ #category : #'instance creation' }
DLList class >> key: aKeyObject value: aValueObject [ 

	^ self new key: aKeyObject value: aValueObject 
]

{ #category : #visit }
DLList >> accept: aVisitor [

	aVisitor visitList: self 
]

{ #category : #initialization }
DLList >> addPair: aPair [

	pairSequence add: aPair
]

{ #category : #initialization }
DLList >> initialize [
	
	
	pairSequence := OrderedCollection new
]

{ #category : #accessing }
DLList >> key [
	^ head key
]

{ #category : #accessing }
DLList >> key: anObject [
	head key: anObject
]

{ #category : #'instance creation' }
DLList >> key: aKeyObject value: aValueObject [ 
	
	head := DLPair new key: aKeyObject ; value: aValueObject
]

{ #category : #printing }
DLList >> prettyPrintString [ 

	^ String streamContents: [ :str |
		self printPrettyOn: str
		]
]

{ #category : #printing }
DLList >> printOn: aStream [

	aStream << '('.
	head printBodyOn: aStream.
	
	self restIsEmpty
		ifFalse: [ aStream space.
	pairSequence 
		do: [ :each | aStream print: each ] 
		separatedBy: [ aStream space ] ].
	aStream << ')'.
]

{ #category : #printing }
DLList >> printPrettyOn: aStream [
  aStream << '('.
  head printBodyOn: aStream.
  self restIsNotEmpty ifTrue: [ 
			aStream cr.
			pairSequence do: [:each |  each printPrettyOn: aStream ] separatedBy: [ aStream space ] ].
  aStream << ')'
  
]

{ #category : #accessing }
DLList >> rest [

	^ pairSequence 
]

{ #category : #initialization }
DLList >> restDo: aBlock [ 
	
	pairSequence do: aBlock
]

{ #category : #testing }
DLList >> restIsEmpty [
	^ pairSequence isEmpty
]

{ #category : #testing }
DLList >> restIsNotEmpty [
	^ pairSequence isNotEmpty
]

{ #category : #accessing }
DLList >> value [
	^ head value
]

{ #category : #accessing }
DLList >> value: anObject [
	head value: anObject
]
