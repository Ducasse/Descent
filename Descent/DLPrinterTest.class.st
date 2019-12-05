Class {
	#name : #DLPrinterTest,
	#superclass : #TestCase,
	#category : #'Descent-DataStructure'
}

{ #category : #tests }
DLPrinterTest >> testPrinterSimplePair [
	| p |
	p := DLPair key: 'olala' value: 'itscool'.
	self assert: (DLPrinter new print: p) equals: '(olala : itscool)'
]
