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
	
	media := DefaultContactMedia forStringContent.
	
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
		assert: ( ( ContactBook current allContacts collect: [ 
			:aContact | 
			( aContact printedTo: media ) content ] ) joinUsing: ', ' )
		equals: 'contact: < name: Abdelrazek, email: a@b.c >'
]

{ #category : #tests }
ContactBookIntegrationTest >> testRemovingContactFromBook [
	
	book addContact: contact.
	
	book removeContact: contact.
	
	VORepository current flush.

	self 
		assert: ( ( ContactBook current allContacts collect: [ 
			:aContact | 
			( aContact printedTo: media ) content ] ) joinUsing: ', ' )
		equals: ''
]
