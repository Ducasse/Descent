Class {
	#name : #DImplicitLexerTest2,
	#superclass : #DImplicitLexerTest,
	#category : #'Descent-Parser'
}

{ #category : #testing }
DImplicitLexerTest2 class >> shouldInheritSelectors [ 

	^ true
]

{ #category : #running }
DImplicitLexerTest2 >> lexer [

	^ DImplicitStringLexer2 new
]

{ #category : #'test comments' }
DImplicitLexerTest2 >> testCommentAtBeginningAndEnd [

	l on: '#this is a starting comment#
	(title: Le lrintemls d''helliconia
	 (read: no) (price: 1))
	#this is an ending comment#'.
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
	self assert: l nextToken equals: ''.
]

{ #category : #'test comments' }
DImplicitLexerTest2 >> testCommentSimple [

	l on: '(title: Le lrintemls d''helliconia
	#this is a comment#
	 (read: no) (price: 1))'.
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

{ #category : #'test comments' }
DImplicitLexerTest2 >> testCommentWithEscapeCharacter [
	
	self skip.
	self flag: #todo. 
	"check why it is broken"
	
	l on: '(title: 
	#this is a first comment with \ inside# 
	Le lrintemls d''helliconia
	(read: no) 
	(test: \# this is not a comment \#) 
	(price: 1))'.
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
	self assert: l nextToken equals: 'test'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: '# this is not a comment #'.
	self assert: l nextToken equals: $).
	self assert: l nextToken equals: $(.
	self assert: l nextToken equals: 'price'.
	self assert: l nextToken equals: $:.
	self assert: l nextToken equals: '1'.
	self assert: l nextToken equals: $).
	self assert: l nextToken equals: $).
]

{ #category : #'test comments' }
DImplicitLexerTest2 >> testIsCurrentCommentChar [

	l on: '#'.
	self assert: l isCurrentCommentChar
]

{ #category : #'test comments' }
DImplicitLexerTest2 >> testIsCurrentEscapeChar [

	l on: '\'.
	self assert: l isCurrentEscapeChar
]

{ #category : #'test comments' }
DImplicitLexerTest2 >> testSuccessiveComments [

	l on: '(title: #this is a first comment##this is a second comment#Le lrintemls d''helliconia
	 (read: no) #this is a third comment##this is a fourth comment#(price: 1))'.
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
