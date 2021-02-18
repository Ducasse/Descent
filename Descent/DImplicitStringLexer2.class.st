"
To keep the code of ilyas.
"
Class {
	#name : #DImplicitStringLexer2,
	#superclass : #DImplicitStringLexer,
	#category : #'Descent-Parser'
}

{ #category : #'Under cooking' }
DImplicitStringLexer2 >> eatComment [
	self flag: #todo.
	"requires more tests."

	self isCurrentCommentChar 
		ifFalse: [ self error: 'This is not a comment!' ]
		ifTrue: [ self consume ].
	[ self isCurrentCommentChar or: [self isAtEnd] ] whileFalse: [ self consume ].
	self isCurrentCommentChar
		ifTrue: [ self consume ].
	self isCurrentCommentChar
		ifTrue: [ self eatComment ].
]

{ #category : #'Under cooking' }
DImplicitStringLexer2 >> eatWhitespacesAndComments [
	self flag: #todo.
	"requires more tests."

		self isCurrentCommentChar
		ifTrue: [ self eatComment ].
	self isCurrentSpace
		ifTrue: [ self eatWhitespace ].
	(self isCurrentCommentChar or: self isCurrentSpace)
		ifTrue: [ self eatWhitespacesAndComments ]
		
]

{ #category : #'Under cooking' }
DImplicitStringLexer2 >> isCurrentALetter [
	self flag: #todo.
	"requires more tests."
	
	^ self isCurrentSeparator not and: [ self isNotAtEnd ]
]

{ #category : #'Under cooking' }
DImplicitStringLexer2 >> name [
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

{ #category : #'Under cooking' }
DImplicitStringLexer2 >> nextToken [
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
