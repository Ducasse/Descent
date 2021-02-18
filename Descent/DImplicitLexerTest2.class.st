Class {
	#name : #DImplicitLexerTest2,
	#superclass : #DImplicitLexerTest,
	#category : #'Descent-Parser'
}

{ #category : #testing }
DImplicitLexerTest2 class >> shouldInheritSelectors [ 

	^ true
]

{ #category : #'tests consume' }
DImplicitLexerTest2 >> lexer [

	^ DImplicitStringLexer2 new
]
