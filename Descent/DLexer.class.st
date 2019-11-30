Class {
	#name : #DLexer,
	#superclass : #Object,
	#instVars : [
		'stream',
		'white',
		'sep',
		'currentChar'
	],
	#category : #Descent
}

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
	^ { $( . $) . $: . $,}
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

{ #category : #token }
DLexer >> isAtEnd [

	^ currentChar isNil
]

{ #category : #token }
DLexer >> isNotAtEnd [

	^ currentChar isNotNil
]

{ #category : #token }
DLexer >> name [ 

	| token |
	token := (String new: 100) writeStream.
	[ currentChar isLetter ] whileTrue: 
			[ token nextPut: currentChar. 
			self consume ].
	^ token contents
]

{ #category : #token }
DLexer >> nextToken [
	"Return a token or an empty string"

	| gotSep |
	[ self isNotAtEnd ]
		whileTrue: [ 
		 	(white includes: currentChar)
				ifTrue: [ self eatWhitespace ]. 
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

{ #category : #accessing }
DLexer >> white [
	^ white
]

{ #category : #accessing }
DLexer >> white: anObject [
	white := anObject
]
