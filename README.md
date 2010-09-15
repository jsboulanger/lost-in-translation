# Lost in Translation (lit)

WARNING: the core logic has been implemented but this is not usable just yet.

Lost in translation is a tool to help you manage your i18n translation strings in your ruby/rails projects.

It's still under heavy development but it currently implements a function that finds the translation strings of your locale files that are not used anymore.

## TODO

 * Make it a gem
 * Handle :scope option (cascading)
 * Add an option to configure method names


## Features List

...

## How does it work?

Lost in translations parses your ruby and erb files into an abstract syntax tree and finds all the calls to the 'translate' method inside your code. It is not perfect, but it generally works better than a regexp-based approach. 

## Limitations

...

## Dependencies

i18n
ruby_parser
erubis

actionview (optional but makes it work better with Rails)
