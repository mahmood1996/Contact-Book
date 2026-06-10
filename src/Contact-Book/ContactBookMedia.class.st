"
`ContactBookMedia` is the Superclass of medias for printing the information of the `ContactBook`.

It takes `contacts` and format the content of the contacts as `String` or in any other format. 

The main idea is to preserve the encapsulation of `ContactBook`, by telling it to inject its contacts to a media to print it in any format. 

To Use it, just pass it to `printedTo:` message of `ContactBook`. To get the formatted content send the message `content` to the result of `printedTo:`  
like ` ( ContactBook new addContact: ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ); printedTo: DefaultContactBookMedia forStringContent ) content `

Public API and Key Messages

- withContacts: 
- content 

Here is a quick example: 

` ( ContactBook new addContact: ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ); printedTo: DefaultContactBookMedia forStringContent ) content `
"
Class {
	#name : #ContactBookMedia,
	#superclass : #Media,
	#category : #'Contact-Book'
}

{ #category : #'instance creation' }
ContactBookMedia >> withContacts: allContacts [
	
	self subclassResponsibility 
]
