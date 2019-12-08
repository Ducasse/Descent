Class {
	#name : #DLPairTest,
	#superclass : #TestCase,
	#category : #'Descent-DataStructure'
}

{ #category : #tests }
DLPairTest >> testCreation [ 

	| p |
	p := DLPair new.
	p key: 1.
	p value: 2.
	self assert: p key equals: 1.
	self assert: p value equals: 2.
]

{ #category : #tests }
DLPairTest >> testCreation2 [ 

	| p |
	p := DLPair key: 1 value: 2.
	self assert: p key equals: 1.
	self assert: p value equals: 2.
]

{ #category : #tests }
DLPairTest >> testNull [

	| p |
	p := DLPair null.
	self assert: p key isNil.
	self assert: p value isNil
]

{ #category : #tests }
DLPairTest >> testPrintOn [

	| p |
	p := DLPair key: 1 value: 2.
	self assert: p printString equals: '(1 : 2)'
]
