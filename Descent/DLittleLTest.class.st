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
	self assert: pair printString equals: '(read: no)'
]
