"
`Contact` is the model representing a contact in the real world.

It takes `name`, and `email` and can print itself to a `ContactMedia`

Public API and Key Messages

- updateName: 
- updateEmail: 
- nameMatching:
- emailMatching:
- printedTo: 

Here is a quick example: 

` ( ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) printedTo: DefaultContactMedia forStringContent ) content `
"
Class {
	#name : #Contact,
	#superclass : #Object,
	#instVars : [
		'name',
		'email'
	],
	#category : #'Contact-Book'
}

{ #category : #'class initialization' }
Contact class >> initialize [ 

	( VOMongoRepository host: 'localhost' database: 'contactbook' ) enableSingleton
]

{ #category : #testing }
Contact class >> isVoyageRoot [ 
	"Indicates that this model will be a separate entity to be saved or retrieved"
	
	^ true
]

{ #category : #'instance creation' }
Contact class >> withName: aName andEmail: anEmail [ 
	"Creates a new instance with name and email"

	^ self new 
		updateName: aName; 
		updateEmail: anEmail; 
		yourself
]

{ #category : #'testing - matching' }
Contact >> emailMatching: aString [ 
	"Check for contact email is matching `aString`"
	
	^ email includesSubstring: aString caseSensitive: false
]

{ #category : #private }
Contact >> gravatarUrl [ 
	"Returns gravatar URL of current contact"
	^ 'http://www.gravatar.com/avatar/', (MD5 hashMessage: email
		trimBoth asLowercase) hex, '.jpg'
]

{ #category : #initialization }
Contact >> initialize [ 
	super initialize.
	
	self updateName: ''.
	
	self updateEmail: ''
]

{ #category : #'testing - matching' }
Contact >> nameMatching: aString [ 
	"Check for contact name is matching `aString`"
	
	^ name includesSubstring: aString caseSensitive: false
]

{ #category : #printing }
Contact >> printedTo: aContactMedia [ 
	"Prints contact data (name and email) to the media"
	
	^ ( ( aContactMedia withName: name ) withEmail: email ) 
		withAvatar: self gravatarUrl
]

{ #category : #updating }
Contact >> updateEmail: aString [ 
	"Updates contact email"

	email := aString.

]

{ #category : #updating }
Contact >> updateName: aString [ 
	"Updates contact name"

	name := aString.

]
