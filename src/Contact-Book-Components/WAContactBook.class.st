Class {
	#name : #WAContactBook,
	#superclass : #WAComponent,
	#instVars : [
		'book'
	],
	#category : #'Contact-Book-Components'
}

{ #category : #private }
WAContactBook class >> contactAsTableData: aContact [
	"Returns contact as HTML code"
	
	^ ( aContact printedTo: ( DefaultContactMedia forFormattedContentUsing: [ 
		:aName :anEmail :anAvatar |
		 { '<td>' , aName , '</td>' .
			'<td>' , anEmail , '</td>' . 
			'<td> <img src= "' , anAvatar , '" /> </td>' } joinUsing: '' ] ) ) content
]

{ #category : #'class initialization' }
WAContactBook class >> initialize [ 
	(WAAdmin register: self asApplicationAt: 'contacts')
		addLibrary: JQDeploymentLibrary;
		addLibrary: TBSDeploymentLibrary
]

{ #category : #initialization }
WAContactBook >> initialize [ 

	super initialize.
	
	book := ContactBook current
]

{ #category : #private }
WAContactBook >> renderAddButtonOn: html [
	html tbsButton
		beSuccess;
		callback: [ self call: ( WAContact forCreatingIn: book ) ];
		with: 'Add contact'
]

{ #category : #private }
WAContactBook >> renderContact: aContact on: html [
	html tableRow: [ 
		html html: ( self class contactAsTableData: aContact ).
		html tableData: [ 
			self renderEditButtonForContact: aContact on: html.
			self renderRemoveButtonForContact: aContact on: html.
		]
	]
]

{ #category : #private }
WAContactBook >> renderContactsOn: html [
		html tbsTable: [
			html tableHead: [
				html
					tableHeading: 'Name';
					tableHeading: 'Email';
					tableHeading: 'Photo'
				]. 
		
				book allContacts do: [ :aContact | self renderContact: aContact on: html ] 
		]
]

{ #category : #rendering }
WAContactBook >> renderContentOn: html [
	"Main entry point of the view. Render a title."
	html tbsContainer: [
		html heading
			level: 1;
			with: 'My Contact Book'.
		
		html tbsForm: [
			self renderContactsOn: html.
			self renderAddButtonOn: html
		].
	]
]

{ #category : #private }
WAContactBook >> renderEditButtonForContact: aContact on: html [
	html tbsButton
		beSuccess;
		callback: [ self call: ( WAContact forEditing: aContact ) ];
		with: 'Edit'
]

{ #category : #private }
WAContactBook >> renderRemoveButtonForContact: aContact on: html [
	html tbsButton
		beDanger;
		callback: [ book removeContact: aContact ];
		with: 'Remove'
]

{ #category : #updating }
WAContactBook >> updateRoot: anHtmlRoot [
	
	super updateRoot: anHtmlRoot.
	
	anHtmlRoot title: 'Contact Book'
]
