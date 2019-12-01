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

{ #category : #accessing }
DLPair >> key: aString [ 
	key := aString
]

{ #category : #printing }
DLPair >> printOn: aStream [

	aStream nextPutAll: '(', key ,': ', value asString, ')'
]

{ #category : #accessing }
DLPair >> value [
	^ value
]

{ #category : #accessing }
DLPair >> value: anObject [
	value := anObject
]
