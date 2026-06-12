"
`ContactBook` is the model representing a catalog of contacts in the real world.

It can add, remove contact and print itself to a `ContactBookMedia`

Public API and Key Messages

- addContact: 
- removeContact: 
- printedTo: 

Here is a quick example: 

` ( ContactBook new addContact: ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ); printedTo: DefaultContactBookMedia forStringContent ) content `
"
Class {
	#name : #ContactBook,
	#superclass : #Object,
	#instVars : [
		'contacts'
	],
	#category : #'Contact-Book'
}

{ #category : #accessing }
ContactBook class >> current [
	^ self selectAll 
		ifEmpty: [ ^ self new save ; yourself ] 
		ifNotEmpty: [ :books | books anyOne ]
]

{ #category : #'class initialization' }
ContactBook class >> initialize [ 

	( VOMongoRepository host: 'localhost' database: 'contactbook' ) enableSingleton
]

{ #category : #testing }
ContactBook class >> isVoyageRoot [ 

	^ true
]

{ #category : #adding }
ContactBook >> addContact: aContact [ 

	aContact save.
	
	contacts add: aContact.
	
	self save
]

{ #category : #accessing }
ContactBook >> allContacts [
	"Returns all saved contacts"
	^ contacts copy asArray 
]

{ #category : #initialization }
ContactBook >> initialize [
	super initialize.
	
	contacts := OrderedCollection new
]

{ #category : #removing }
ContactBook >> removeContact: aContact [ 

	contacts remove: aContact.
	
	aContact remove.
	
	self save
]
