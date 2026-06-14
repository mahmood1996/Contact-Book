"
`DefaultContactMedia` is a subclass of `ContactMedia` for printing the information of the `Contact`.

It takes `name`, and `email` and format the content as `String` or in any other format. 

The main idea is to preserve the encapsulation of `Contact`, by tell it to inject its info to a media to print it in any format. 

To Use it, just pass it to `printedTo:` message of `Contact`. To get the formatted content send the message `content` to the result of `printedTo:` 
like ` ( ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) printedTo: DefaultContactMedia forStringContent ) content `

Public API and Key Messages

- withName: 
- withEmail: 
- To create instance use `DefaultContactMedia forStringContent`. 
- For custom formatted content use `DefaultContactMedia forFormattedContentUsing: [ :aName :anEmail | ]`.

Here is a quick example: 

` ( ( Contact withName: 'Abdelrazek' andEmail: 'a@b.c' ) printedTo: DefaultContactMedia forStringContent ) content `
"
Class {
	#name : #DefaultContactMedia,
	#superclass : #ContactMedia,
	#instVars : [
		'props',
		'formattedContentBlock'
	],
	#category : #'Contact-Book'
}

{ #category : #'instance creation' }
DefaultContactMedia class >> forFormattedContentUsing: contentBlock [
	"Creates a new instance with this block for formatting content"

	^ self new withFormattedContent: contentBlock
]

{ #category : #'instance creation' }
DefaultContactMedia class >> forJSONContent [
	"Creates an instance for formatting content as String".
	
	^ self forFormattedContentUsing: [
		 :aName :anEmail :anAvatar |
		 {	'name' -> aName . 
		 	'email' -> anEmail .
		 	'avatar' -> anAvatar } asDictionary ]
]

{ #category : #'instance creation' }
DefaultContactMedia class >> forStringContent [
	"Creates an instance for formatting content as String".
	
	^ self forFormattedContentUsing: [ 
		:aName :anEmail :anAvatar | 
		'contact: < ' , ( { 'name: ' , aName . 'email: ' , anEmail } joinUsing: ', ' ) , ' >' ]
]

{ #category : #formatting }
DefaultContactMedia >> content [
	"Returns formatted content of `props` (name and email)"
	
	^ formattedContentBlock 
		value: (props at: 'name') 
		value: (props at: 'email')
		value: (props at: 'avatar')
]

{ #category : #initialization }
DefaultContactMedia >> initialize [ 
	super initialize.
	
	props := { 'name' -> '' . 'email' -> '' . 'avatar' -> '' } asDictionary.
	
	formattedContentBlock := [ :name :email :avatar |  ]
]

{ #category : #'instance creation' }
DefaultContactMedia >> withAvatar: aUrl [
	"Returns new instance with an avatar"

	props at: 'avatar' put: aUrl.
	
	^ self copy
]

{ #category : #'instance creation' }
DefaultContactMedia >> withEmail: aString [
	"Returns new instance with an email"

	props at: 'email' put: aString.
	
	^ self copy
]

{ #category : #private }
DefaultContactMedia >> withFormattedContent: contentBlock [
	"Returns new instance with a block for formatting props"

	formattedContentBlock := contentBlock.
	
	^ self copy
]

{ #category : #'instance creation' }
DefaultContactMedia >> withName: aString [
	"Returns new instance with a name"

	props at: 'name' put: aString.
	
	^ self copy
]
