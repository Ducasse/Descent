Class {
	#name : #DLexerTest,
	#superclass : #TestCase,
	#instVars : [
		'l'
	],
	#category : #'Descent-Parser'
}

{ #category : #tests }
DLexerTest >> setUp [
	
	l := DLexer new.

]

{ #category : #'tests consume' }
DLexerTest >> testConsume [

	l on: 'abc'.
	self assert: l currentChar equals: $a.
	l consume.
	self assert: l currentChar equals: $b.
	l consume.
	self assert: l currentChar equals: $c.
	l consume.
	self assert: l isAtEnd
]

{ #category : #tests }
DLexerTest >> testEmpty [

	l on: ''.
	self assert: l nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DLexerTest >> testEmptyConsume [

	l on: ''.
	self assert: l currentChar isNil.
	l consume.
	
]

{ #category : #tests }
DLexerTest >> testOnlySpace [

	l on: '   	
		'.
	self assert: l nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DLexerTest >> testSepConsume [

	l on: '('.
	self assert: l currentChar equals: $(.
	
]

{ #category : #tests }
DLexerTest >> testSimple [ 

	l on: '(title: '.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:
	
	
]

{ #category : #tests }
DLexerTest >> testSimple2 [

	l on: '(title: Le lrintemls d''helliconia (read: no) (price: 1))'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: 'Le'.
	self assert: l nextToken equals: 'lrintemls'.
	self assert: l nextToken equals: 'd''helliconia'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'read'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: 'no'.
	self assert: l nextToken equals: $).
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'price'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: '1'.
	self assert: l nextToken equals: $).
	self assert: l nextToken equals: $).
]

{ #category : #tests }
DLexerTest >> testSpaceAndSep [

	l on: '    (    '.
	self assert: l nextToken equals: $(.
	
]

{ #category : #tests }
DLexerTest >> testSpaceAndSep2 [

	l on: '    (       )   '.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: $).
	
]

{ #category : #'tests consume' }
DLexerTest >> testSpaceConsume [

	l on: '  '.
	self assert: l currentChar equals: Character space.
	l consume.
	self assert: l currentChar equals: Character space.
	l consume. 
	self assert: l isAtEnd
]
