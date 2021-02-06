"
I am a copy of class DLexer. This comment is copied from there, and might not be entirely accurate

I'm a simple lexer.

I recogniseI 
	names: list of characters letter and number and '
	separators: one character separator. 
	
Whitespaces and separators can be customised using setters.

Subclasses may change the definition of names by redefining isCurrentALetter.

Next iteration should manage an escape character, and explicit list ""il fait beau, ou pas"" to avoid to use escape char
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
DImplicitStringLexer >> eatComment [
	self isCurrentCommentChar 
		ifFalse: [ self error: 'This is not a comment!' ]
		ifTrue: [ self consume ].
	[ self isCurrentCommentChar or: self isAtEnd ] whileFalse: [ self consume ].
	self isCurrentCommentChar
		ifTrue: [ self consume ].
		
	self isCurrentCommentChar
		ifTrue: [ self eatComment ].
		
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

{ #category : #eating }
DImplicitStringLexer >> eatWhitespacesAndComments [
	self isCurrentCommentChar
		ifTrue: [ self eatComment ].
	self isCurrentSpace
		ifTrue: [ self eatWhitespace ].
	(self isCurrentCommentChar or: self isCurrentSpace)
		ifTrue: [ self eatWhitespacesAndComments ]
		
]

{ #category : #accessing }
DImplicitStringLexer >> escape [
	^ escape
]

{ #category : #accessing }
DImplicitStringLexer >> escape: anObject [
	escape := anObject
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
	
	^ self isCurrentSeparator not and: self isNotAtEnd
]

{ #category : #eating }
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

{ #category : #eating }
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
		 	self eatWhitespacesAndComments.
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
