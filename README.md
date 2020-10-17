Please organize this todo list before you are done

# TODO
* Extract all forms and cards from views to partials
  * Try to share similar partials in a single file
  * Maybe an arguement could be passed from where it is called (along with the object to render)
    That arguement would determine which form gets loaded based off an if statement in the partial
    Then we could pass in which form we want to request all to the same form partial
     and the partial would render the correct form in the view
* Add comments for everything so far
* Update readme to document what is going on with the application
* Add tests for User and Articles models, controllers, functions

* Integrate ActionCable for a chat/messaging section
* Disable or edit the about page
* Get rid of bootstrap and replace with custom html/css/js
* Update jumbotron with more appropriate info

* Provide instructions for setting up the project on a local machine

* Update css to use variables for colors instead of specifying color in all places

* edit 404 files for custom 404 pages (public folder)

* Add before actions to comments before methods in controllers

* Add functionality for an admin to make another user an admin (superuser?)

Considerations:

  Application Controller
  * Consider using object.present? instead of !! in logged_in? method

  Nav Partial
  * adjust elements to be more centered in the screen for larger displays

  Form Partial
  * set to handle with ajax (see local: true) https://guides.rubyonrails.org/form_helpers.html
  * use if logged_in? for both sets of buttons for consistency

  Delete unused files:
    app/helpers/pages_helper.rb

  MOAR TESTS


