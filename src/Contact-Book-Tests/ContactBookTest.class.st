Class {
	#name : #ContactBookTest,
	#superclass : #TestCase,
	#instVars : [
		'book',
		'media',
		'contact',
		'prevRepository'
	],
	#category : #'Contact-Book-Tests'
}

{ #category : #running }
ContactBookTest >> setUp [
	super setUp.
	
	prevRepository := VORepository current.
	
	VORepository setRepository: VOMemoryRepository new.
	
	book := ContactBook new.
	
	media := DefaultContactBookMedia forStringContent.
	
	contact := Contact withName: 'Abdelrazek' andEmail: 'a@b.c'
	

]

{ #category : #running }
ContactBookTest >> tearDown [ 

	VORepository setRepository: prevRepository.
	
	super tearDown
]

{ #category : #tests }
ContactBookTest >> testAddingContactToBook [
	
	book addContact: contact.

	self assert: (book printedTo: media) content equals: 'contacts: [ contact: < name: Abdelrazek, email: a@b.c > ]'
]

{ #category : #tests }
ContactBookTest >> testPrintingEmptyBook [

	self assert: (book printedTo: media) content equals: 'contacts: []'
]

{ #category : #tests }
ContactBookTest >> testRemovingContactFromBook [
	
	book 
		addContact: contact;
		removeContact: contact.

	self assert: (book printedTo: media) content equals: 'contacts: []'
]
