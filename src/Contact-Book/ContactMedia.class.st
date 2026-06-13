"
`ContactMedia` is the Superclass of medias for printing the information of the `Contact`.

It takes `name`, `email`, and `an avatar` and format the content as `String` or in any other format. 

The main idea is to preserve the encapsulation of `Contact`, by tell it to inject its info to a media to print it in any format. 

To Use it, just pass it to `printedTo:` message of `Contact`. To get the formatted content send the message `content` to the result of `printedTo:` 
like ` ( ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) printedTo: DefaultContactMedia forStringContent ) content `

Public API and Key Messages

- withName: 
- withEmail: 
- withAvatar:
- content 

Here is a quick example: 

` ( ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) printedTo: DefaultContactMedia forStringContent ) content `
"
Class {
	#name : #ContactMedia,
	#superclass : #Object,
	#category : #'Contact-Book'
}

{ #category : #formatting }
ContactMedia >> content [
	"Returns formatted content of `props` (name, email, and an avatar)"

	self subclassResponsibility.
]

{ #category : #'instance creation' }
ContactMedia >> withAvatar: anUrl [
	"Returns new instance with a avatar url"

	self subclassResponsibility.
]

{ #category : #'instance creation' }
ContactMedia >> withEmail: aString [
	"Returns new instance with an email"
	
	self subclassResponsibility
]

{ #category : #'instance creation' }
ContactMedia >> withName: aString [
	"Returns new instance with a name"

	self subclassResponsibility.
]
