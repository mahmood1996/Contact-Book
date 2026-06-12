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

	self assert: ( book allContacts includes: contact )
]

{ #category : #tests }
ContactBookTest >> testNoContactsForEmptyBook [

	self assert: book allContacts isEmpty
]

{ #category : #tests }
ContactBookTest >> testRemovingContactFromBook [
	
	book 
		addContact: contact;
		removeContact: contact.

	self deny: (book allContacts includes: contact)
]
