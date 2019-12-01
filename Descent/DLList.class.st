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
	#category : #Descent
}

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
DLList >> printOn: aStream [

	aStream << '('.
	head printBodyOn: aStream.
	aStream space.
	pairSequence 
		do: [ :each | aStream print: each ] 
		separatedBy: [ aStream space ].
	aStream << ')'.
]

{ #category : #initialization }
DLList >> restDo: aBlock [ 
	
	pairSequence do: aBlock
]

{ #category : #testing }
DLList >> restIsEmpty [
	^ pairSequence isEmpty
]

{ #category : #accessing }
DLList >> value [
	^ head value
]

{ #category : #accessing }
DLList >> value: anObject [
	head value: anObject
]
