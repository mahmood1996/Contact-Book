Class {
	#name : #ContactTest,
	#superclass : #TestCase,
	#instVars : [
		'prevRepository'
	],
	#category : #'Contact-Book-Tests'
}

{ #category : #running }
ContactTest >> setUp [
	super setUp.
	
	prevRepository := VORepository current.
	
	VORepository setRepository: VOMemoryRepository new.
	
	
]

{ #category : #running }
ContactTest >> tearDown [ 

	VORepository setRepository: prevRepository.
	
	super tearDown
]

{ #category : #tests }
ContactTest >> testPrintingContact [
	| contact media |
	
	media := DefaultContactMedia forStringContent .
	
	contact := Contact withName: 'Abdelrazek' andEmail: 'a@b.c'.
	
	self assert: (contact printedTo: media) content equals: 'contact: < name: Abdelrazek, email: a@b.c >'
]
