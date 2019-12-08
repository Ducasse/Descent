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
	l addPairToRest: (DLPair new key: 3; value: 4).
	self assert: l rest first key equals:  3.
	self deny: l restIsEmpty.
	l addPairToRest: (DLPair new key: 5; value: 6).
	self assert: l rest first key equals: 3.
	self assert: l rest first key equals: 3.
	self assert: l rest last key equals: 5.


]

{ #category : #tests }
DLListTest >> testCharLf [
	
	self assert: Character lf asString equals: (String streamContents: [:s | s lf ])
]

{ #category : #tests }
DLListTest >> testCharLf2 [
	"this test is special because it embedds a string that contains a lf"

	| buggyButcontainingLF | 
	"(String streamContents: [:s | s lf ]) to produce the string buggyButcontainingLF below"
	buggyButcontainingLF := '
'.
	self assert: (buggyButcontainingLF at: 1) equals: Character lf.
	self assert: Character lf asString equals:  '
'
]

{ #category : #tests }
DLListTest >> testCreation [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPairToRest: (DLPair new key: 3; value: 4).
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
	l addPairToRest: ((DLList key: 3 value: 4) addPairToRest: (DLPair key: 33 value: 44)).
	l addPairToRest: (DLPair key: 5  value: 6).
	self 
		assert: l printString 
		equals: '(1 : 2 (3 : 4 (33 : 44)) (5 : 6))' 	

]

{ #category : #tests }
DLListTest >> testPrintOn [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPairToRest: (DLPair new key: 3; value: 4).
	l addPairToRest: (DLPair new key: 5; value: 6).
	self assert: l printString equals: '(1 : 2 (3 : 4) (5 : 6))'.
 	

]

{ #category : #tests }
DLListTest >> testPrintOnListOfList [
	
	| l |
	l := DLList new.
	l key: 1 value: 2.
	l addPairToRest: ((DLList key: 3 value: 4) addPairToRest: (DLPair new key: 33; value: 44)).
	l addPairToRest: (DLPair new key: 5; value: 6).
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
	l addPairToRest: (DLPair new key: 3; value: 4).
	l addPairToRest: (DLPair new key: 5; value: 6).
	self assert: l prettyPrintString equals:'(1 : 2', Character lf asString,'(3 : 4) (5 : 6))' 
	"Pay attention that the string should contain lf and not cr"
]
