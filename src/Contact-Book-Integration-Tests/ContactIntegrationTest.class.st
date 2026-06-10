Class {
	#name : #ContactIntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'prevRepository'
	],
	#category : #'Contact-Book-Integration-Tests'
}

{ #category : #running }
ContactIntegrationTest >> setUp [
	super setUp.
	
	prevRepository := VORepository current.
	
	VORepository setRepository: ( VOMongoRepository host: 'localhost' database: 'TestContactBook' ).
	
	Contact removeAll
]

{ #category : #running }
ContactIntegrationTest >> tearDown [ 

	VORepository setRepository: prevRepository.
	
	super tearDown
]

{ #category : #tests }
ContactIntegrationTest >> testSavingContact [
	| contact |

	contact := ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) 
					updateEmail: 'a@test.c'; 
					yourself.
	
	contact save.
	
	self assert: Contact count equals: 1.

	self assert: Contact selectAll first equals: contact
]
