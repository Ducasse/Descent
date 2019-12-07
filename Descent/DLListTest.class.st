Class {
	#name : #DLListTest,
	#superclass : #TestCase,
	#category : #'Descent-DataStructure'
}

{ #category : #tests }
DLListTest >> testAddingIsAddingLast [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: (DLPair new key: 3; value: 4).
	self assert: l rest first key equals:  3.
	self deny: l restIsEmpty.
	l addPair: (DLPair new key: 5; value: 6).
	self assert: l rest first key equals: 3.
	self assert: l rest first key equals: 3.
	self assert: l rest last key equals: 5.


]

{ #category : #tests }
DLListTest >> testCreation [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: (DLPair new key: 3; value: 4).
	self deny: l restIsEmpty.


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
DLListTest >> testPolymorphicCreationMessage [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: ((DLList key: 3 value: 4) addPair: (DLPair key: 33 value: 44)).
	l addPair: (DLPair key: 5  value: 6).
	self 
		assert: l printString 
		equals: '(1 : 2 (3 : 4 (33 : 44)) (5 : 6))' 	

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
DLListTest >> testPrintOnListOfList [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: ((DLList key: 3 value: 4) addPair: (DLPair new key: 33; value: 44)).
	l addPair: (DLPair new key: 5; value: 6).
	self 
		assert: l printString 
		equals: '(1 : 2 (3 : 4 (33 : 44)) (5 : 6))' 	

]

{ #category : #tests }
DLListTest >> testPrintOnSimpleVersion [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	self assert: l printString equals: '(1 : 2)'.
 
]

{ #category : #tests }
DLListTest >> testPrintPrettyOn [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPair: (DLPair new key: 3; value: 4).
	l addPair: (DLPair new key: 5; value: 6).
	self assert: l prettyPrintString equals:'(1 : 2
(3 : 4) (5 : 6))' 
]
