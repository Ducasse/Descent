"
I represent a pair: a:b and c:d in the following


( a : b )
( a : b ( c : d))

The question could be if it should have the same query method than DLList related to rest. 
"
Class {
	#name : #DLPair,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Descent-DataStructure'
}

{ #category : #'instance creation' }
DLPair class >> key: aKey value: aValue [ 
	^ self new key: aKey ; value: aValue; yourself
]

{ #category : #'instance creation' }
DLPair class >> null [ 

	^ self new 
]

{ #category : #visit }
DLPair >> accept: aVisitor [

	aVisitor visitPair: self
]

{ #category : #accessing }
DLPair >> key [
	^ key
]

{ #category : #accessing }
DLPair >> key: aString [ 
	key := aString
]

{ #category : #accessing }
DLPair >> key: aKey value: aValue [ 
	key := aKey.
	value := aValue
]

{ #category : #printing }
DLPair >> printBodyOn: aStream [

	aStream << key asString.
	aStream << ' : '.
	aStream << value asString.


]

{ #category : #printing }
DLPair >> printOn: aStream [

	aStream << '('.
	self printBodyOn: aStream.
	aStream << ')'

]

{ #category : #printing }
DLPair >> printPrettyOn: aStream [

	aStream << '('.
	self printBodyOn: aStream.
	aStream << ')'

]

{ #category : #accessing }
DLPair >> value [
	^ value
]

{ #category : #accessing }
DLPair >> value: anObject [
	value := anObject
]
