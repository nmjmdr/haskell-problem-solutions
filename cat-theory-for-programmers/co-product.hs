module CoProduct where

data Contact = Phone Int | Email String

primaryContact::Contact
primaryContact = Phone 1234

secondaryContact::Contact
secondaryContact = Email "email@email.com"


