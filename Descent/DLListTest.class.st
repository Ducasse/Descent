Class {
	#name : #DLListTest,
	#superclass : #TestCase,
	#category : #Descent
}

{ #category : #tests }
DLListTest >> testCreation [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: (DLPair new key: 3; value: 4).
	self deny: l restIsEmpty.
	l addPair: (DLPair new key: 5; value: 6).

]

{ #category : #tests }
DLListTest >> testCreationSimple [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	self assert: l key equals: 1.
	self assert: l value equals: 2.
	self assert: l restIsEmpty.

]

{ #category : #tests }
DLListTest >> testPrintOn [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: (DLPair new key: 3; value: 4).
	l addPair: (DLPair new key: 5; value: 6).
	self assert: l printString equals: '(1 : 2 (3 : 4) (5 : 6))'.
 	

]

{ #category : #tests }
DLListTest >> testPrintOnSimpleVersion [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	self assert: l printString equals: '(1 : 2)'.
 
]
