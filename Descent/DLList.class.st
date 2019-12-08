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

{ #category : #adding }
DLList >> addPairToRest: aPair [

	pairSequence add: aPair
]

{ #category : #iterating }
DLList >> do: aBlock [ 
	"Perform a block on each elements."
	
	aBlock value: head.
	pairSequence do: aBlock
]

{ #category : #accessing }
DLList >> head [ 
	^ head
]

{ #category : #initialization }
DLList >> initialize [
	super initialize.
	head := DLPair new.
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

{ #category : #initialization }
DLList >> key: aKeyObject value: aValueObject [ 
	
	head key: aKeyObject ; value: aValueObject
]

{ #category : #iterating }
DLList >> keysAndValuesDo: aBlock [ 
	"Perform a block with a key and value on each elements."
	
	aBlock value: head key value: head value.
	pairSequence do: [ :p| aBlock value: p key value: p value ] 
]

{ #category : #accessing }
DLList >> last [

	^ self restIsNotEmpty
		ifTrue: [ pairSequence last ]
		ifFalse: [ DLPair null ]
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
			aStream lf.
			pairSequence 
				do: [:each |  each printPrettyOn: aStream ] 
				separatedBy: [ aStream space ] ].
  aStream << ')'
  
]

{ #category : #accessing }
DLList >> rest [

	^ pairSequence 
]

{ #category : #iterating }
DLList >> restDo: aBlock [ 
	"Perform a block on the rest of the receiver."
	
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
