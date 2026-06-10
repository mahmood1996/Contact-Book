Class {
	#name : #ContactBookIntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'prevRepository',
		'book',
		'contact',
		'media'
	],
	#category : #'Contact-Book-Integration-Tests'
}

{ #category : #private }
ContactBookIntegrationTest >> removeStoredObjects [

	Contact removeAll.
	
	ContactBook removeAll
]

{ #category : #running }
ContactBookIntegrationTest >> setUp [
	super setUp.
	
	prevRepository := VORepository current.
	
	VORepository setRepository: ( VOMongoRepository host: 'localhost' database: 'TestContactBook' ).
	
	self removeStoredObjects.
	
	book := ContactBook current.
	
	media := DefaultContactBookMedia forStringContent.
	
	contact := Contact withName: 'Abdelrazek' andEmail: 'a@b.c'
]

{ #category : #running }
ContactBookIntegrationTest >> tearDown [ 

	self removeStoredObjects.

	VORepository setRepository: prevRepository.
	
	super tearDown
]

{ #category : #tests }
ContactBookIntegrationTest >> testAddingContactToBook [
	
	book addContact: contact.
	
	VORepository current flush.

	self 
		assert: (ContactBook selectAll first printedTo: media) content 
		equals: 'contacts: [ contact: < name: Abdelrazek, email: a@b.c > ]'
]

{ #category : #tests }
ContactBookIntegrationTest >> testRemovingContactFromBook [
	
	book addContact: contact.
	
	book removeContact: contact.
	
	VORepository current flush.

	self 
		assert: (ContactBook current printedTo: media) content 
		equals: 'contacts: []'
]
