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

{ #category : #tests }
DImplicitLexerTest >> testAllTokens [

	l on: '(author : Aldiss Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	 	(title: Helliconia l''ete (read: no)  (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1))
  (books:
    	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))'.

	self assert: l allTokens equals:  #($( 'author' $: 'Aldiss Brian' $( 'serie' $: 'helliconia' $( 'title' $: 'Le printemps d''helliconia' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'title' $: 'Helliconia l''ete' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'title' $: 'L''hiver d''helliconia' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'books' $: $( 'title' $: 'L''instant de l''eclipse' $( 'read' $: 'no' $) $( 'style' $: 'fantaisie' $) $( 'price' $: '1' $) $) )
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
DImplicitLexerTest >> testEscape [

	l on: '(title\(Titre\): '.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title(Titre)'.
	self assert: l nextToken equals: $:
]

{ #category : #tests }
DImplicitLexerTest >> testEscape2 [

	l on: '(title : Les \vents du changement (read : no) (style : SF) (price : 2.39))'').'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals:  'Les vents du changement' 
]

{ #category : #tests }
DImplicitLexerTest >> testEscapeOnLast [

	l on: '(ve \))'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals:  've )'. 
	self assert: l nextToken equals: $).
]

{ #category : #tests }
DImplicitLexerTest >> testEscapeOnWhiteSpace [

	l on: '(title : Les\ vents du changement \(read \: no\) (style : SF) (price : 2.39))'').'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals:  'Les vents du changement (read : no)' 
]

{ #category : #tests }
DImplicitLexerTest >> testIsCurrentSeparator [
	
	l on: 'a'.
	self assert: l isCurrentSeparator not. 
	l on: ')'.
	self assert: l isCurrentSeparator. 
]

{ #category : #tests }
DImplicitLexerTest >> testIsCurrentSpace [

	l on: ' '.
	self assert: l isCurrentSpace
]

{ #category : #tests }
DImplicitLexerTest >> testNextTokens [

	l on: '(author : Aldiss Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	 	(title: Helliconia l''ete (read: no)  (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1))
  (books:
    	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))'.

	self assert: (l nextTokens: 92)  equals:  #($( 'author' $: 'Aldiss Brian' $( 'serie' $: 'helliconia' $( 'title' $: 'Le printemps d''helliconia' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'title' $: 'Helliconia l''ete' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'title' $: 'L''hiver d''helliconia' $( 'read' $: 'no' $) $( 'style' $: 'SF' $) $( 'price' $: '1' $) $) $( 'books' $: $( 'title' $: 'L''instant de l''eclipse' $( 'read' $: 'no' $) $( 'style' $: 'fantaisie' $) $( 'price' $: '1' $) $) '')
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

	l on: '(title: Le lrintemls d''helliconia (read: no) (price: 1))'.
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'title'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: 'Le lrintemls d''helliconia'.
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
