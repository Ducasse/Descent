Class {
	#name : #DLPair,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #Descent
}

{ #category : #accessing }
DLPair >> key [
	^ key
]

{ #category : #'as yet unclassified' }
DLPair >> key: aString [ 
	key := aString
]

{ #category : #accessing }
DLPair >> value [
	^ value
]

{ #category : #accessing }
DLPair >> value: anObject [
	value := anObject
]
