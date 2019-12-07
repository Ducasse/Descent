"
I'm a simple lexer.

I recogniseI 
	names: list of characters letter and number and '
	separators: one character separator. 
	
Whitespaces and separators can be customised using setters.

Subclasses may change the definition of names by redefining isCurrentALetter.

Next iteration should manage an escape character, and explicit list ""il fait beau, ou pas"" to avoid to use escape char
"
Class {
	#name : #DLexer,
	#superclass : #Object,
	#instVars : [
		'stream',
		'white',
		'sep',
		'currentChar'
	],
	#category : #'Descent-Parser'
}

{ #category : #accessing }
DLexer >> atEndValue [

	^ ''
]

{ #category : #eating }
DLexer >> consume [
	
	currentChar := stream next 
]

{ #category : #accessing }
DLexer >> currentChar [

	^ currentChar 
]

{ #category : #initialization }
DLexer >> defaultSeparators [
	^ { $( . $) . $:}
]

{ #category : #initialization }
DLexer >> defaultWhitespaces [
	^  { Character space. Character tab . Character lf . Character cr }. 

]

{ #category : #eating }
DLexer >> eatFromExpectedCharacter: expectedCharacter [
	currentChar = expectedCharacter
		ifTrue: [ self consume ]
      ifFalse: [ Error new messageText: 'Expecting ', expectedCharacter asString, 'and got ', currentChar asString] 
]

{ #category : #eating }
DLexer >> eatWhitespace [
	[ white includes: currentChar ] whileTrue: [ self consume ]
]

{ #category : #initialization }
DLexer >> initialize [ 
	white := self defaultWhitespaces. 
	sep := self defaultSeparators 
]

{ #category : #testing }
DLexer >> isAtEnd [

	^ currentChar isNil
]

{ #category : #testing }
DLexer >> isCurrentALetter [ 

	^ currentChar isAlphaNumeric or: [ currentChar = $' ]
]

{ #category : #testing }
DLexer >> isNotAtEnd [

	^ currentChar isNotNil
]

{ #category : #token }
DLexer >> name [
	| token |
	token := (String new: 100) writeStream.
	[ self isCurrentALetter ]
		whileTrue: [ token nextPut: currentChar.
			self consume ].
	^ token contents
]

{ #category : #token }
DLexer >> nextToken [
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
							^ self name.
							]
			]
	



]

{ #category : #initialization }
DLexer >> on: aString [

	stream := aString readStream.
	aString ifNotEmpty: [ 
		self consume ]
]

{ #category : #accessing }
DLexer >> sep [
	^ sep
]

{ #category : #accessing }
DLexer >> sep: anObject [
	sep := anObject
]

{ #category : #initialization }
DLexer >> separatorCharacters: aCol [
	sep := aCol
	
]

{ #category : #accessing }
DLexer >> white [
	^ white
]

{ #category : #accessing }
DLexer >> white: anObject [
	white := anObject
]

{ #category : #initialization }
DLexer >> whitespaceCharacters: aCol [
	white := aCol
	
]
