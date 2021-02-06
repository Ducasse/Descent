"
A little list description language parser named DLittle.

(a:b 
	(c:d (e:f) (g:h))
	(z:k (r:t) (p:q)))

Hand written to feel the pain. 
The idea is to refactor it to get a canonical shape. 

(author : Aldiss, Brian 
  (serie : helliconia  
   		(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	 	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	  	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1)))
  (books : default
    	( title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))))

In yaml 
	a:b is a dict at:put: 
	- is a list of item
i.e.,

Moorcock, Michael : 
  Legende d'hawkmoon secret des Runes : 
   - { title: Le joyau noir, number: 1, read: no, originalTitle: ""The jewel in the Skull"", year: 1967}
   - { title: Le dieu fou, number: 2, read: no, originalTitle: ""The Mad God’s Amulet"", year: 1968}
  Legende d'hawkmoon secret des Compte d'airain : 
   - { title: Le comte Airain, number: 5, read: no, originalTitle: ""Count Brass"", year: 1973}
   - { title: Le champion de Garathorm, number: 6, read: no, originalTitle: ""The Champion of Garathorm"", year: 1973}
   - { title:  La quête de Tanelorn, number: 7, read: no, originalTitle: ""The quest of Garathorm"", year: 1975}

In DLittle we get list by construction. 

DLittle Grammar:
start -> Pair
Pair ->  '(' Key ':' Value Following ')'	
Following ->   ('(' Pair ')') *
Key -> char*
Value -> char*

To do Next iteration
	- escape character \?
	- and/or using "" for a string when eveything is escaped. ""
	
	- Now we have only on sexp like stuff (with nested sexp)
		(a:b 
			(c:d (e:f) (g:h))
			(c:d (e:f) (g:h)))
		Do we want to have list of sexp without having nesting?
		It would means that the file can be cut in the middle and we lost half of data.
		
A possible variation is to introduce , to avoid ( )

(author : Aldiss / Brian 
  (serie : helliconia  
   		(title: Le printemps d'helliconia, read: no,  style: SF, price: 1)
  	 	(title: Helliconia, l'ete, read: no,  style: SF, price: 1)
 	  	(title: L'hiver d'helliconia, read: no,  style: SF, price: 1))
  (books:
    	( title: L'instant de l'eclipse, read: no,  style: fantaisie, price: 1))



Next point is to have a DTD like description (expressed in DLittle) to map key to models.
The idea there is how to map DLittle expression so a more complex meta model: books, series, authors...

DTD
<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>
<!DOCTYPE liste_de_gens [
 <!ELEMENT liste_de_gens (personne)*>
 <!ELEMENT personne (nom, date_de_naissance?, genre?, numero_de_secu?)>
 <!ELEMENT nom (#PCDATA)>
 <!ELEMENT date_de_naissance (#PCDATA)>
 <!ELEMENT genre (#PCDATA | masculin | féminin) ""féminin"">
 <!ELEMENT numero_de_secu (#PCDATA)>
]>



"
Class {
	#name : #DLittleLParser,
	#superclass : #Object,
	#instVars : [
		'l'
	],
	#category : #'Descent-Parser'
}

{ #category : #parsing }
DLittleLParser class >> parse: aString [ 
	
	^ self new parse: aString
]

{ #category : #parsing }
DLittleLParser >> parse: aString [ 

	l := DImplicitStringLexer new.
	l on: aString.
	^ self scanPair
]

{ #category : #parsing }
DLittleLParser >> parseMultiple: aString [ 
	| result |
	result := OrderedCollection new.
	l := DImplicitStringLexer new.
	l on: aString.
	[[true] whileTrue: [ result add: self scanPair ]]
		 on: Error
			do: [^result]
]

{ #category : #parsing }
DLittleLParser >> scanPair [
	| pair |
	l nextToken = $(
		ifFalse: [ self error: 'Missing (' ]
		ifTrue: [ 
			pair := self scanPairBody.
			^ pair ]
]

{ #category : #parsing }
DLittleLParser >> scanPairBody [
	| key value skipValue sep pair isOpening |
	key := l nextToken.
	sep := l nextToken.
	sep = $:
		ifFalse: [ self error: 'Missing :' ]
		ifTrue: [ 
				"skipValue is used to permit to write (key: (subKey1: subValue1)..) without value"
				isOpening := l nextToken.
				skipValue := isOpening = $(.
				skipValue ifFalse:
				[ value := isOpening ].
				pair := DLList new key: key value: value.
			
				[skipValue or: [ isOpening := l nextToken.
				isOpening = $( ]] whileTrue: 
						[ pair addPairToRest: self scanPairBody.
						skipValue := false ].	
				isOpening = $) ifFalse: [ self error: 'Missing )' ] ].
				^ pair  
			
]
