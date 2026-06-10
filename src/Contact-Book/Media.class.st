"
`Media` is the Superclass of all medias.

The idea of `Media` is to be used as a channel that takes infomation from the data holder and format it via `content`

Public API and Key Messages

- content 



"
Class {
	#name : #Media,
	#superclass : #Object,
	#category : #'Contact-Book'
}

{ #category : #formatting }
Media >> content [
	"Returns formatted content"

	self subclassResponsibility
]
