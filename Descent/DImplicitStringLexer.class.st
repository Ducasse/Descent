"
I'm a simple lexer. I'm used by the DLitlleLParser.

I recognise
	- names: list of characters letter and number and '
	- separators: one character separator. 
	- escape char backlash

Whitespaces and separators can be customised using setters.
Subclasses may change the definition of names by redefining isCurrentALetter.
"
Class {
	#name : #DImplicitStringLexer,
	#superclass : #Object,
	#instVars : [
		'stream',
		'white',
		'sep',
		'escape',
		'currentChar'
	],
	#category : #'Descent-Parser'
}

{ #category : #token }
DImplicitStringLexer >> allTokens [
  "Return all the tokens"
  | tokens |
  tokens := OrderedCollection new.
  [ self isNotAtEnd ] whileTrue: [ tokens add: self nextToken ].
  ^ tokens asArray
]

{ #category : #accessing }
DImplicitStringLexer >> atEndValue [

	^ ''
]

{ #category : #eating }
DImplicitStringLexer >> consume [
	
	currentChar := stream next 
]

{ #category : #accessing }
DImplicitStringLexer >> currentChar [

	^ currentChar 
]

{ #category : #initialization }
DImplicitStringLexer >> defaultEscapeChars [
	^ { $\ }
]

{ #category : #initialization }
DImplicitStringLexer >> defaultSeparators [
	^ { $( . $) . $: }
]

{ #category : #initialization }
DImplicitStringLexer >> defaultWhitespaces [
	^  { Character space. Character tab . Character lf . Character cr }. 

]

{ #category : #eating }
DImplicitStringLexer >> eatFromExpectedCharacter: expectedCharacter [
	currentChar = expectedCharacter
		ifTrue: [ self consume ]
      ifFalse: [ Error new messageText: 'Expecting ', expectedCharacter asString, 'and got ', currentChar asString] 
]

{ #category : #eating }
DImplicitStringLexer >> eatWhitespace [
	[ white includes: currentChar ] whileTrue: [ self consume ]
]

{ #category : #accessing }
DImplicitStringLexer >> escape [
	^ escape
]

{ #category : #initialization }
DImplicitStringLexer >> initialize [ 
	white := self defaultWhitespaces. 
	sep := self defaultSeparators.
	escape := self defaultEscapeChars 
]

{ #category : #testing }
DImplicitStringLexer >> isAtEnd [

	^ currentChar isNil
]

{ #category : #testing }
DImplicitStringLexer >> isCurrentALetter [ 

	"^ currentChar isAlphaNumeric or: [ currentChar = $' ]"
	
	^ self isCurrentSeparator not
]

{ #category : #testing }
DImplicitStringLexer >> isCurrentCommentChar [

	^ currentChar = $#
]

{ #category : #eating }
DImplicitStringLexer >> isCurrentEscapeChar [

	^ escape includes: currentChar 
]

{ #category : #eating }
DImplicitStringLexer >> isCurrentSeparator [

	^ sep includes: currentChar 
]

{ #category : #eating }
DImplicitStringLexer >> isCurrentSpace [

	^ white includes: currentChar 
]

{ #category : #testing }
DImplicitStringLexer >> isNotAtEnd [

	^ currentChar isNotNil
]

{ #category : #accessing }
DImplicitStringLexer >> name [
	| token |
	token := (String new: 100) writeStream.
	
	[ self isCurrentALetter or: [ self isCurrentSpace or: [ self isCurrentEscapeChar ]]  ]
		whileTrue: [ 
			self isCurrentEscapeChar ifTrue: [ 
				self isAtEnd ifTrue: [ self error: 'No character to be escaped' ].
				self consume ].
			self isCurrentCommentChar 
				ifTrue: [ self eatComment ].
			
			token nextPut: currentChar.
			self consume ].
		
	^ token contents
]

{ #category : #token }
DImplicitStringLexer >> nextToken [
	"Return a token or an empty string"

	| gotSep |
	self isAtEnd ifTrue: [ ^ self atEndValue ].
	[ self isNotAtEnd ]
		whileTrue: [ 
		 	(white includes: currentChar)
				ifTrue: [ self eatWhitespace ].
			self isAtEnd ifTrue: [ ^ self atEndValue ].	
			gotSep := sep includes: currentChar.
			gotSep
				ifTrue: [ | tmp | 
							tmp := currentChar. 
							self consume. 
							^ tmp.]
				ifFalse: [ 
							^ self name trimBoth.
							]
			]
	



]

{ #category : #token }
DImplicitStringLexer >> nextTokens: aNumber [
  "Return some  tokens"
  | tokens |
  tokens := OrderedCollection new.
  aNumber timesRepeat: [ tokens add: self nextToken ].
  ^ tokens asArray
]

{ #category : #initialization }
DImplicitStringLexer >> on: aString [

	stream := aString readStream.
	aString ifNotEmpty: [ 
		self consume ]
]

{ #category : #accessing }
DImplicitStringLexer >> sep [
	^ sep
]

{ #category : #accessing }
DImplicitStringLexer >> sep: anObject [
	sep := anObject
]

{ #category : #initialization }
DImplicitStringLexer >> separatorCharacters: aCol [
	sep := aCol
	
]

{ #category : #accessing }
DImplicitStringLexer >> white [
	^ white
]

{ #category : #accessing }
DImplicitStringLexer >> white: anObject [
	white := anObject
]

{ #category : #initialization }
DImplicitStringLexer >> whitespaceCharacters: aCol [
	white := aCol
	
]
