"
A little list description language parser.

Hand written to feel the pain. 
The idea is to refactor it to get a canonical shape. 

Grammar:
pair ->  '(' key ':' value following ')'	
following ->   ('(' pair ')') *

( a : b )
( a : b ( c : d))


(author : Aldiss / Brian 
  (serie : helliconia  
   		(title: Le printemps d'helliconia (read: no)  (style: SF) (price: 1))
  	 	(title: Helliconia, l'ete, read: no,  style: SF, price: 1)
 	  	(title: L'hiver d'helliconia, read: no,  style: SF, price: 1))
  (books:
    	( title: L'instant de l'eclipse (read: no)  (style: fantaisie) (price: 1))



Next iteration
	- handle string or spaces so that we can write ( a : le jour ) and the value should be ""le jour"".

A possible variation is to introduce , to avoid ( )

(author : Aldiss / Brian 
  (serie : helliconia  
   		(title: Le printemps d'helliconia, read: no,  style: SF, price: 1)
  	 	(title: Helliconia, l'ete, read: no,  style: SF, price: 1)
 	  	(title: L'hiver d'helliconia, read: no,  style: SF, price: 1))
  (books:
    	( title: L'instant de l'eclipse, read: no,  style: fantaisie, price: 1))




(authors : 
     (author : foo), (author : herbert)
     (serie : helliconia  

Name : letter+digit+'
Separators  : : ( ) , 
Key : Name







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
	#category : #Descent
}

{ #category : #parsing }
DLittleLParser >> parse: aString [ 

	l := DLexer new.
	l on: aString.
	^ self scanPair
]

{ #category : #parsing }
DLittleLParser >> scanPair [
	| pair |
	l nextToken = $(
		ifFalse: [ self error: 'Missing (' ]
		ifTrue: [ 
			pair := self scanPairBody.
			Transcript show: pair printString.
			^ pair ]
]

{ #category : #parsing }
DLittleLParser >> scanPairBody [
	| key value sep pair isOpening |
	key := l nextToken.
	sep := l nextToken.
	sep = $:
		ifFalse: [ self error: 'Missing :' ]
		ifTrue: [ 
				value := l nextToken.
				pair := DLList new key: key value: value.
				
				[ isOpening := l nextToken.
				isOpening = $( ] whileTrue: 
						[ pair addPair: self scanPairBody ].	
				isOpening = $) ifFalse: [ self error: 'Missing )' ] ].
				^ pair  
			
]
