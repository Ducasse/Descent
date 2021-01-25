Class {
	#name : #DLPrinter,
	#superclass : #DLVisitor,
	#instVars : [
		'stream',
		'tabs'
	],
	#category : #'Descent-DataStructure'
}

{ #category : #visiting }
DLPrinter >> decreaseTab [

	tabs := tabs - 1
]

{ #category : #visiting }
DLPrinter >> increaseTab [

	tabs := tabs + 1
]

{ #category : #initialization }
DLPrinter >> initialize [ 
	super initialize.
	tabs := 0.
	stream := WriteStream on: ''
]

{ #category : #visiting }
DLPrinter >> pairBody: aPair [

	stream 
		<< aPair key asString
		<< ' : ' 
		<< aPair value asString
]

{ #category : #public }
DLPrinter >> print: aDLPair [ 

	aDLPair accept: self.
	^ stream contents
]

{ #category : #visiting }
DLPrinter >> tabulate [
	tabs timesRepeat: [ stream nextPut: Character tab ].
]

{ #category : #visiting }
DLPrinter >> visitHead: aPair [

	self pairBody: aPair
]

{ #category : #visiting }
DLPrinter >> visitList: aList [

	self increaseTab.
	stream nextPut: $(.
	super visitList: aList.
	stream nextPut: $).
	self decreaseTab.
]

{ #category : #visiting }
DLPrinter >> visitPair: aPair [

	stream << '('.
	self pairBody: aPair.
	stream << ')'
]

{ #category : #visiting }
DLPrinter >> visitRest: aCollectionOfPairs [
	stream cr.
	self tabulate.
	aCollectionOfPairs 
		do: [:each | each accept: self ] 
		separatedBy: [ stream cr.
				self tabulate.
				].

]
