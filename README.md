# Alpha Blog
This is my first rails app that was made alongside lessons from [The Complete Ruby On Rails Development Course](https://www.udemy.com/share/101swcB0IbdlxWRXw=/) on [Udemy](https://udemy.com/). Insetad of using gems, generators, or shortcuts most features were done and added by hand such as login functions. The main shortcut that was taken was using bootstrap since html, css, and js weren't in the scope of the course.

This app allows an unregistered user to view a listing of articles, categories, and users. Categories can be assigned to articles and viewing by category will get a paginated list of articles in that category. When browsing by users a user can be selected so their profile can be viewed and their information along with a list of articles they have created is displayed. When a user signs up they can create their own articles to be displayed in their user profile as well as the articles/categories lists. Users are able to edit/delete their own profiles and articles. Users can also be upgraded to admin accounts on the backend. This grants the extra functionality of allowing the admin to delete other user profiles (but not edit), edit/delete articles, create/edit/delete categories.

You can find the demo of this site hosted on heroku here: [Alpha Blog on Heroku](https://alpha-blog-jt2.herokuapp.com/)



## TODO
(Sorted by shorter to longer tasks)

* Update jumbotron with more appropriate info

* Update favicon

* Update css to use variables for colors instead of specifying color in all places

* edit 404 files for custom 404 pages? (public folder)

* Add functionality for an admin to make another user an admin (superuser?)

* Integrate ActionCable for a chat/messaging section

* Check that all possible tests are present

* Add tests for User and Articles models, controllers, functions

* Get rid of bootstrap and replace with custom html/css/js

* Use about page to show project info (use this README as a guide and add link to jumbotron)

### Considerations:

####Application Controller
* Consider using object.present? instead of !! in logged_in? method

#### Nav Partial
* adjust elements to be more centered in the screen for larger displays

#### Form Partial
* set to handle with ajax (see local: true) https://guides.rubyonrails.org/form_helpers.html
* use if logged_in? for both sets of buttons for consistency

#### Delete unused files:
* app/helpers/pages_helper.rb