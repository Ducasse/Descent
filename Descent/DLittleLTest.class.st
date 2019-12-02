Class {
	#name : #DLittleLTest,
	#superclass : #TestCase,
	#category : #Descent
}

{ #category : #tests }
DLittleLTest >> testParseSimplePair [
	| p pair |
	p := DLittleL new. 
	pair := p parse: '(read: no)'.
	self assert: pair key equals: 'read'.
	self assert: pair value equals: 'no'.
	self assert: pair printString equals: '(read : no)'
]

{ #category : #tests }
DLittleLTest >> testParseSimplePairWithRest [
	| p list |
	p := DLittleL new. 
	list := p parse: '(firstKey : firstValue (secondKey: secondValue))'.
	self assert: list key equals: 'firstKey'.
	self assert: list value equals: 'firstValue'.
	self assert: list restIsEmpty not.
]
