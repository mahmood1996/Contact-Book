"
`DefaultContactBookMedia` is a subclass of `ContactBookMedia` for printing the information of the `ContactBook`.

It takes `contacts` and format the content as `String` or in any other format. 

The main idea is to preserve the encapsulation of `ContactBook`, by telling it to inject its info to a media to print it in any format. 

To Use it, just pass it to `printedTo:` message of `ContactBook`. To get the formatted content send the message `content` to the result of `printedTo:` 
like ` ( ContactBook new addContact: ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ); printedTo: DefaultContactBookMedia forStringContent ) content `

Public API and Key Messages

- withContacts: 
- To create an instance use `DefaultContactBookMedia forStringContent`. 
- For custom formatted content use `DefaultContactBookMedia forFormattedContentUsing: [ :allContacts | ]`.

Here is a quick example: 

` ( ContactBook new addContact: ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ); printedTo: DefaultContactBookMedia forStringContent ) content `
"
Class {
	#name : #DefaultContactBookMedia,
	#superclass : #ContactBookMedia,
	#instVars : [
		'contacts',
		'formattedContentBlock'
	],
	#category : #'Contact-Book'
}

{ #category : #'instance creation' }
DefaultContactBookMedia class >> forFormattedContentUsing: contentBlock [

	^ self new withFormattedContent: contentBlock
]

{ #category : #'instance creation' }
DefaultContactBookMedia class >> forStringContent [ 

	| contactContentBlock |
	
	contactContentBlock := [ :aContact | ( aContact printedTo: DefaultContactMedia forStringContent ) content ].
	
	^ self forFormattedContentUsing: [
		 :allContacts |
		 allContacts 
			ifEmpty: [ 'contacts: []' ]
			ifNotEmpty: [ 'contacts: [ ' , ( ( allContacts collect: contactContentBlock ) joinUsing: ', ' ) , ' ]' ] ]
		
	
]

{ #category : #formatting }
DefaultContactBookMedia >> content [
	
	^ formattedContentBlock value: contacts
]

{ #category : #initialization }
DefaultContactBookMedia >> initialize [ 

	super initialize.	
	
	contacts := OrderedCollection new.
	
	formattedContentBlock := [ :allContacts | ]
]

{ #category : #'instance creation' }
DefaultContactBookMedia >> withContacts: allContacts [
	
	contacts := allContacts.
	
	^ self copy
]

{ #category : #private }
DefaultContactBookMedia >> withFormattedContent: contentBlock [
	
	formattedContentBlock := contentBlock.
	
	^ self copy
]
