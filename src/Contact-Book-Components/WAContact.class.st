Class {
	#name : #WAContact,
	#superclass : #WAComponent,
	#instVars : [
		'contact',
		'saveContactBlock'
	],
	#category : #'Contact-Book-Components'
}

{ #category : #'instance creation' }
WAContact class >> forCreatingIn: aContactBook [
	"Returns new instance for creating new contact"
	^ self new 
		onSaveContactDo: [ :contact | aContactBook addContact: contact ]
		yourself
]

{ #category : #'instance creation' }
WAContact class >> forEditing: aContact [
	"Returns new instance for editing this contact"
	^ self new 
		updateContact: aContact; 
		onSaveContactDo: [ :contact | contact save ]
		yourself
]

{ #category : #private }
WAContact >> contactAsDictionary [
	"Returns contact as a Dictionary"
	^ ( contact printedTo: ( DefaultContactMedia forFormattedContentUsing: [
		 :aName :anEmail :anAvatar |
		 {	'name' -> aName . 
		 	'email' -> anEmail .
		 	'avatar' -> anAvatar } asDictionary ] ) ) content
]

{ #category : #initialization }
WAContact >> initialize [ 

	super initialize.
	
	contact := Contact new.
	
	self onSaveContactDo: [ :aContact |  ]
]

{ #category : #private }
WAContact >> onSaveContactDo: aBlock [
	"Updates the block of saving the contact"
	saveContactBlock := [ 
		:aContact | 
		aBlock value: aContact.
		self answer: aContact 
	]
]

{ #category : #private }
WAContact >> renderButtonsOn: html [
	html tbsFormGroup: [
		html tbsButtonGroup: [
			self
				renderSubmitButtonOn: html;
				renderCancelButtonOn: html ] ]
]

{ #category : #private }
WAContact >> renderCancelButtonOn: html [
	html tbsButton
		beDanger;
		cancelCallback: [ self answer: nil ];
		with: 'Cancel'
]

{ #category : #rendering }
WAContact >> renderContentOn: html [
	html tbsContainer: [
		html heading with: 'Contact Editing'.
		html tbsForm with: [
			self renderFieldsOn: html.
			self renderButtonsOn: html ] ].
]

{ #category : #private }
WAContact >> renderEmailFieldOn: html [
	html tbsFormGroup: [
		html label: 'Email'.
		html emailInput
			tbsFormControl;
			placeholder: 'your@email.eu';
			callback: [ :email | contact updateEmail: email address ];
			value: ( self contactAsDictionary at: 'email' ) ]
]

{ #category : #private }
WAContact >> renderFieldsOn: html [
	self renderFullnameFieldOn: html.
	self renderEmailFieldOn: html
]

{ #category : #private }
WAContact >> renderFullnameFieldOn: html [
	html tbsFormGroup: [
		html label: 'Fullname'.
		html textInput
			tbsFormControl;
			placeholder: 'fullname';
			callback: [ :value | contact updateName: value ];
			value: ( self contactAsDictionary at: 'name' ) ]
]

{ #category : #private }
WAContact >> renderSubmitButtonOn: html [
	html tbsSubmitButton
		beSuccess;
		bePrimary;
		callback: [ saveContactBlock value: contact ] ;
		with: 'Save'
]

{ #category : #private }
WAContact >> updateContact: aContact [
	"Updates current contact"
	contact := aContact.
]
