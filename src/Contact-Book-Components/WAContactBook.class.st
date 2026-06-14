Class {
	#name : #WAContactBook,
	#superclass : #WAComponent,
	#instVars : [
		'book',
		'searchKeyword'
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
	
	searchKeyword := ''.
	
	book := ContactBook current.
]

{ #category : #private }
WAContactBook >> renderAddButtonOn: html [
	html tbsButton
		beSuccess;
		callback: [ 
			self call: ( WAContact forCreatingIn: book ). 
			searchKeyword := '' 
		];
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
	html tbsForm: [ 
		html tbsTable: [
			html tableHead: [
				html
					tableHeading: 'Name';
					tableHeading: 'Email';
					tableHeading: 'Photo'
			]. 
			
			searchKeyword 
				ifEmpty: [ book allContacts do: [ :aContact | self renderContact: aContact on: html ] ] 
					
				ifNotEmpty: [ 
					book allContacts 
						select: [ 
							:contact | 
							( contact nameMatching: searchKeyword ) or: ( contact emailMatching: searchKeyword ) ]
						thenDo: [ :aContact | self renderContact: aContact on: html ] 
				]
			]
		]
]

{ #category : #rendering }
WAContactBook >> renderContentOn: html [
	"Main entry point of the view. Render a title."
	html tbsContainer: [
		html heading
			level: 1;
			with: 'My Contact Book'.
			
		self renderSearchFieldOn: html.
		
		html break.
		
		html div 
            id: 'contact-list';
            with: [ self renderContactsOn: html ].

		html tbsForm: [
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

{ #category : #private }
WAContactBook >> renderSearchFieldOn: html [
	html div class: 'search-box'; with: [
		html textInput
			tbsFormControl;
			id: 'search-input';
			placeholder: 'Search by name or email...';
			value: searchKeyword;
			onKeyUp: (html jQuery ajax
				callback: [ :val | searchKeyword := val ]
					value: ((html jQuery id: 'search-input') value);
				onSuccess: ((html jQuery id: 'contact-list') load
					html: [ :r | self renderContactsOn: r ])) ]
]

{ #category : #updating }
WAContactBook >> updateRoot: anHtmlRoot [
	
	super updateRoot: anHtmlRoot.
	
	anHtmlRoot title: 'Contact Book'
]
