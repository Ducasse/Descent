"
I am a copy of class DLexerTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #DImplicitLexerTest,
	#superclass : #TestCase,
	#instVars : [
		'l'
	],
	#category : #'Descent-Parser'
}

{ #category : #'tests consume' }
DImplicitLexerTest >> setUp [
	l := DImplicitStringLexer new.
	
]

{ #category : #'tests consume' }
DImplicitLexerTest >> testConsume [
	
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
DImplicitLexerTest >> testEmpty [

	l on: ''.
	self assert: l nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DImplicitLexerTest >> testEmptyConsume [

	l on: ''.
	self assert: l currentChar isNil.
	l consume.
	
]

{ #category : #tests }
DImplicitLexerTest >> testOnlySpace [
	
	l on: '   	
		'.
	self assert: l nextToken equals: ''.
	
]

{ #category : #'tests consume' }
DImplicitLexerTest >> testSepConsume [

	l on: '('.
	self assert: l currentChar equals: $(.
	
]

{ #category : #tests }
DImplicitLexerTest >> testSimple [ 

	l on: '(title: '.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:
	
	
]

{ #category : #tests }
DImplicitLexerTest >> testSimple2 [

	l on: '(title: Le lrintemls d''helliconia, read: no, price: 1)'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: 'Le'.
	self assert: l nextToken equals: 'lrintemls'.
	self assert: l nextToken equals: 'd''helliconia'.
	self assert: l nextToken equals: $,.
	self assert: l nextToken equals: 'read'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: 'no'.
	self assert: l nextToken equals: $,.
	self assert: l nextToken equals: 'price'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: '1'.
	self assert: l nextToken equals: $).
]

{ #category : #tests }
DImplicitLexerTest >> testSpaceAndSep [

	l on: '    (    '.
	self assert: l nextToken equals: $(.
	
]

{ #category : #tests }
DImplicitLexerTest >> testSpaceAndSep2 [

	l on: '    (       )   '.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: $).
	
]

{ #category : #'tests consume' }
DImplicitLexerTest >> testSpaceConsume [

	l on: '  '.
	self assert: l currentChar equals: Character space.
	l consume.
	self assert: l currentChar equals: Character space.
	l consume. 
	self assert: l isAtEnd
]
