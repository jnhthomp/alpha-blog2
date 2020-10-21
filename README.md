# Alpha Blog
This is my first rails app that was made alongside lessons from [The Complete Ruby On Rails Development Course](https://www.udemy.com/share/101swcB0IbdlxWRXw=/) on [Udemy](https://udemy.com/). Insetad of using gems, generators, or shortcuts most features were done and added by hand such as login functions. The main shortcut that was taken was using bootstrap since html, css, and js weren't in the scope of the course.

This app allows an unregistered user to view a listing of articles, categories, and users. Categories can be assigned to articles and viewing by category will get a paginated list of articles in that category. When browsing by users a user can be selected so their profile can be viewed and their information along with a list of articles they have created is displayed. When a user signs up they can create their own articles to be displayed in their user profile as well as the articles/categories lists. Users are able to edit/delete their own profiles and articles. Users can also be upgraded to admin accounts on the backend. This grants the extra functionality of allowing the admin to delete other user profiles (but not edit), edit/delete articles, create/edit/delete categories.

You can find the demo of this site hosted on heroku here: [Alpha Blog on Heroku](https://alpha-blog-jt2.herokuapp.com/)

Also feel free to check out the sitemap that is included in the [Alpha-Blog-Map.drawio](Alpha-Blog-Map.drawio) file to see the flow of the site.



## TODO
(Sorted by shorter to longer tasks)

* edit 404 files for custom 404 pages? (public folder)

* Add functionality for an admin to make another user an admin (superuser?)

* Integrate ActionCable for a chat/messaging section

* Add user password requirements

* Check that all possible tests are present
  * Move as much out of setup and into test_helper as possible
  * Update helper method functions to set defaults in the function
  * Allow these defaults to be overwritten when the method is called by providing a key/value
  * remove .save from 'create' helper methods and add where necessary

* Add tests for User and Articles models, controllers, functions

* Get rid of bootstrap and replace with custom html/css/js

* Use about page to show project info (use this README as a guide and add link to jumbotron)

### Considerations:

#### Application Controller
* Consider using object.present? instead of !! in logged_in? method

#### Nav Partial
* adjust elements to be more centered in the screen for larger displays

#### Form Partial
* set to handle with ajax (see local: true) https://guides.rubyonrails.org/form_helpers.html
* use if logged_in? for both sets of buttons for consistency

#### Delete unused files:
* app/helpers/pages_helper.rb



----------------------------------------------------------------------------------------------
Tests status:

    controllers
DONE    	categories_controller_test.rb
DONE    		Have:
DONE    			"should not create category if not admin"
DONE    			"should show category"
DONE          "Should get index"
DONE    			"should get new"
DONE    			"should get edit"
DONE    			"Should create category"
DONE    			"should update category"
DONE    			"Should not update if not admin"
DONE    			"Should destroy category"
    	pages_controller_test.rb
    		Need:
    			"should get home"
    			"should not get home if logged in"
    	articles_controller_test.rb
    	sessions_controller_test.rb
    	users_controller_test.rb
    	
    integration
    	create_category_test.rb
    		Have:
    			"get new category form and create category"
    			"get new category form and reject invalid category submission"
    	modify_category_test.rb
    		Need:
    			"get existing category and successfully update name"
    			"get existing category and reject invalid name"
    			"delete existing category"
    	list_categories_test.rb
    		Have:
    			"should show categories listing"
    	create_article_test.rb
    		Need:
    			"get new article form and create new article"
    			"get new article form and reject invalid article"
    	modify_article_test.rb
    		Need:
    			"get existing article and successfully update"
    			"get existing article and reject invalid update"
    			"delete existing article"
    			"reject article deletion if not same user or admin"
    	create_user_test.rb
    		need:
    			"Get new user form and create new user"
    			"get new user form and reject invalid user"
    	modify_user_test.rb
    		Need:
    			"get existing user and successfully update"
    			"get existing user and reject invalid update"
    			"delete existing user"
    			"reject user deletion if not same user or admin"
    	
    	
DONE    models
DONE    	category_test.rb
DONE    		Have:
DONE          "category should be valid"
DONE          "name should be present"
DONE    			"name should be unique"
DONE    			"name should not be too long"
DONE    			"name should not be too short"
DONE    	article_categories_test.rb
DONE    		Have:
DONE          "should be valid"
DONE    			"must have article"
DONE    			"must have category"
DONE    	article_test.rb
DONE    		Have:
DONE    			"must have user"
DONE    			"must have title"
DONE    			"title should not be too short"
DONE    			"title should not be too long"
DONE    			"must have description"
DONE    			"description cannot be too short"
DONE    			"description cannot be too long"
DONE    	user_test.rb
DONE    		Need:
DONE    			"user articles should be destroyed when user is destroyed"
DONE    			"must have username"
DONE    			"username must be unique"
DONE    			"username should not be too short"
DONE    			"username should not be too long"
DONE    			"must have email"
DONE    			"email must be unique"
DONE    			"email must not be too long"
DONE    			"email must follow regex format"
DONE    			"must have password_digest"
DONE    			"password is hashed"
DONE          "user is not admin by default
    
    test_helper.rb
    	sign_in_as(user)
    		receiver an obj with user credentials specified 
    		user must have been created and added to users table before this is called
    		user must have the same password as the one listed in this test