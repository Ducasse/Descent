# DLittle 

[![Build Status](https://travis-ci.com/Ducasse/Descent.svg?branch=master)](https://travis-ci.com/Ducasse/Descent)
[![Coverage Status](https://coveralls.io/repos/github/Ducasse/Descent/badge.svg?branch=master)](https://coveralls.io/github/Ducasse/Descent?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Ducasse/enlumineur/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)

A little language named DLittle to represent simple data and not be forced to use YAML.


Power to lisp-like syntax!

```
(a:b 
	(c:d (e:f) (g:h))
	(z:k (r:t) (p:q)))
```
Hand written to feel the pain. 

```
(author : Aldiss / Brian 
  (serie : helliconia  
  	(title: Le printemps d''helliconia (read: no)  (style: SF) (price: 1))
  	(title: Helliconia, l''ete (read: no)  (style: SF) (price: 1))
 	(title: L''hiver d''helliconia (read: no)  (style: SF) (price: 1))
  (books : individual
    	(title: L''instant de l''eclipse (read: no)  (style: fantaisie) (price: 1))
 ```     
      
## Installation

To install the packages of DLittle, go to the Playground (Ctrl+OW) in your Pharo image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Descent';
  repository: 'github://Ducasse/Descent/'
```

## If you want to depend on it

```
spec 
   baseline: 'ContainersBTree' 
   with: [ spec repository: 'github://Ducasse/Descent/' ].
```

----
The best way to predict the future is to do it.
Talking less doing more. stepharo@netcourrier.com


