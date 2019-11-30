Class {
	#name : #DLexerTest,
	#superclass : #TestCase,
	#category : #Descent
}

{ #category : #'tests consume' }
DLexerTest >> testConsume [
	| p | 
	p := DLexer new.
	p on: 'abc'.
	self assert: p currentChar equals: $a.
	p consume.
	self assert: p currentChar equals: $b.
	p consume.
	self assert: p currentChar equals: $c.
	p consume.
	self assert: p isAtEnd
]

{ #category : #tests }
DLexerTest >> testEmpty [
	| p | 
	p := DLexer new.
	p on: ''.
	self assert: p nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DLexerTest >> testEmptyConsume [
	| p | 
	p := DLexer new.
	p on: ''.
	self assert: p currentChar isNil.
	
]

{ #category : #tests }
DLexerTest >> testOnlySpace [
	| p | 
	p := DLexer new.
	p on: '   	
		'.
	self assert: p nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DLexerTest >> testSepConsume [
	| p | 
	p := DLexer new.
	p on: '('.
	self assert: p currentChar equals: $(.
	
]

{ #category : #tests }
DLexerTest >> testSimple [ 
	|  p | 
	p := DLexer new.
	p on: '(title: '.
	self assert: p nextToken equals: $(.
	self assert: p nextToken equals: 'title'.
	self assert: p nextToken equals: $:
	
	
]

{ #category : #tests }
DLexerTest >> testSimple2 [
	| p | 
	p := DLexer new.
	p on: '(title: Le printemps d''helliconia, read: no, price: 1)'.
	self assert: p nextToken equals: $(.
	self assert: p nextToken equals: 'title'.
	self assert: p nextToken equals: $:.
	self assert: p nextToken equals: 'Le'.
	self assert: p nextToken equals: 'printemps'.
	self assert: p nextToken equals: 'd''helliconia'.
	self assert: p nextToken equals: $,.
	self assert: p nextToken equals: 'read'.
	self assert: p nextToken equals: $:.
	self assert: p nextToken equals: 'no'.
	self assert: p nextToken equals: $,.
	self assert: p nextToken equals: 'price'.
	self assert: p nextToken equals: $:.
	self assert: p nextToken equals: '1'.
	self assert: p nextToken equals: $).
]

{ #category : #tests }
DLexerTest >> testSpaceAndSep [
	|  p | 
	p := DLexer new.
	p on: '    (    '.
	self assert: p nextToken equals: $(.
	
]

{ #category : #tests }
DLexerTest >> testSpaceAndSep2 [
	|  p | 
	p := DLexer new.
	p on: '    (       )   '.
	self assert: p nextToken equals: $(.
	self assert: p nextToken equals: $).
	
]

{ #category : #'tests consume' }
DLexerTest >> testSpaceConsume [
	| p | 
	p := DLexer new.
	p on: '  '.
	self assert: p currentChar equals: Character space.
	p consume.
	self assert: p currentChar equals: Character space.
	p consume. 
	self assert: p isAtEnd
]
