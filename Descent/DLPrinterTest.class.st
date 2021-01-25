Class {
	#name : #DLPrinterTest,
	#superclass : #TestCase,
	#category : #'Descent-DataStructure'
}

{ #category : #tests }
DLPrinterTest >> testPrinterMorePair [
	| l |
	l := DLList key: 'author' value: 'Bob'.
	l addPairToRest: ((DLList key: 'serie' value: 'Wargames') addPairToRest: (DLPair key: 'title' value: 'JolyJumper')).
	l addPairToRest: (DLPair key: 'serie'  value: 'Foobar').
	self 
		assert: (DLPrinter new print: l)
		equals:
 '(author : Bob
	(serie : Wargames
		(title : JolyJumper))
	(serie : Foobar))'		
]

{ #category : #tests }
DLPrinterTest >> testPrinterSimplePair [
	| p |
	p := DLPair key: 'olala' value: 'itscool'.
	self assert: (DLPrinter new print: p) equals: '(olala : itscool)'
]

{ #category : #tests }
DLPrinterTest >> testPrinterTwoRealSubList [
	| l |
	l := DLList key: 'author' value: 'Bob'.
	l addPairToRest: ((DLList key: 'serie' value: 'Wargames') addPairToRest: (DLList key: 'title' value: 'JolyJumper')).
	l addPairToRest: ((DLList key: 'serie'  value: 'Foobar') addPairToRest: (DLList key: 'title' value: 'Foobar attacks')).
	self 
		assert: (DLPrinter new print: l)
		equals: 
 '(author : Bob
	(serie : Wargames
		(title : JolyJumper))
	(serie : Foobar
		(title : Foobar attacks)))'		
]

{ #category : #tests }
DLPrinterTest >> testPrinterTwoSubList [
	| l |
	l := DLList key: 'author' value: 'Bob'.
	l addPairToRest: ((DLList key: 'serie' value: 'Wargames') addPairToRest: (DLPair key: 'title' value: 'JolyJumper')).
	l addPairToRest: ((DLList key: 'serie'  value: 'Foobar') addPairToRest: (DLPair key: 'title' value: 'Foobar attacks')).
	self 
		assert: (DLPrinter new print: l)
		equals:
 '(author : Bob
	(serie : Wargames
		(title : JolyJumper))
	(serie : Foobar
		(title : Foobar attacks)))'	
]
