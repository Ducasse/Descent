Class {
	#name : #DLittleLTest,
	#superclass : #TestCase,
	#category : #Descent
}

{ #category : #tests }
DLittleLTest >> testParseFullExample [
	| p list |
	p := DLittleL new. 
	list := p parse: '(author : Aldiss 
  (serie : helliconia  
   		(title: Printempts (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia (read: no)  (style: SF) (price: 1)
 	  	(title: hiver (read: no)  (style: SF) (price: 1))))
  (books : bla
    	( title: eclipse (read: no)  (style: fantaisie) (price: 1))))'.
	self assert: list printString equals: '(author : Aldiss (serie : helliconia (title : Printempts (read : no) (style : SF) (price : 1)) (title : Helliconia (read : no) (style : SF) (price : 1) (title : hiver (read : no) (style : SF) (price : 1)))) (books : bla (title : eclipse (read : no) (style : fantaisie) (price : 1))))'
]

{ #category : #tests }
DLittleLTest >> testParseSimplePair [
	| p pair |
	p := DLittleL new. 
	pair := p parse: '(read: 1)'.
	self assert: pair key equals: 'read'.
	self assert: pair value equals: '1'.
	self assert: pair printString equals: '(read : 1)'
]

{ #category : #tests }
DLittleLTest >> testParseSimplePairWithRest [
	| p list |
	p := DLittleL new. 
	list := p parse: '(firstKey : firstValue (secondKey: secondValue))'.
	self assert: list key equals: 'firstKey'.
	self assert: list value equals: 'firstValue'.
	self assert: list restIsEmpty not.
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue))'
]

{ #category : #tests }
DLittleLTest >> testParseSimplePairWithRest2 [
	| p list |
	p := DLittleL new. 
	list := p parse: '(firstKey : firstValue (secondKey : secondValue (key : val)))'.
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue (key : val)))'
]

{ #category : #tests }
DLittleLTest >> testParseSimplePairWithRestList [
	| p list |
	p := DLittleL new. 
	list := p parse: '(firstKey : firstValue (secondKey: secondValue) (thirdKey : thirdValue))'.
	self assert: list key equals: 'firstKey'.
	self assert: list value equals: 'firstValue'.
	self assert: list restIsEmpty not.
	
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue) (thirdKey : thirdValue))'
]
