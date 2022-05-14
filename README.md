# Alpha Blog 📝
<a href="https://jtdev.netlify.app/" target="_blank" rel="noreferrer"> <img src="https://drive.google.com/uc?id=19ZZ2aDajCwqqMiawXZRcjEKScT1z5657" alt="JTDEV" width="100%" height="auto"/> </a> 
This is my first rails app that was made alongside lessons from [The Complete Ruby On Rails Development Course](https://www.udemy.com/share/101swcB0IbdlxWRXw=/) on [Udemy](https://udemy.com/). Insetad of using gems, generators, or shortcuts most features were done and added by hand such as login functions. The main shortcut that was taken was using bootstrap since html, css, and js weren't in the scope of the course.

This app allows an unregistered user to view a listing of articles, categories, and users. Categories can be assigned to articles and viewing by category will get a paginated list of articles in that category. When browsing by users a user can be selected so their profile can be viewed and their information along with a list of articles they have created is displayed. When a user signs up they can create their own articles to be displayed in their user profile as well as the articles/categories lists. Users are able to edit/delete their own profiles and articles. Users can also be upgraded to admin accounts on the backend. This grants the extra functionality of allowing the admin to delete other user profiles (but not edit), edit/delete articles, create/edit/delete categories.

You can find the demo of this site hosted on heroku here: [Alpha Blog on Heroku](https://alpha-blog-jt2.herokuapp.com/)

Also feel free to check out the sitemap that is included in the [Alpha-Blog-Map.drawio](Alpha-Blog-Map.drawio) file to see the flow of the site.

<!-- Preview gif -->
<a href="https://drive.google.com/uc?id=1PHfkQCdJI2yO1VwA5KFaKevlQqf2jGAY" target="_blank" rel="noreferrer"> <img src="https://drive.google.com/uc?id=1PHfkQCdJI2yO1VwA5KFaKevlQqf2jGAY" alt="JTDEV" width="100%" height="auto" /> </a> 

## How It's Made:
**Tech used:** <!-- Ruby on Rails --><a href="https://rubyonrails.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a> <!-- Ruby --><a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a><!-- Sass --><a href="https://sass-lang.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/sass/sass-original.svg" alt="sass" width="40" height="40"/> </a> 

For a detailed explanation of how this application works please see the [classNotes repo](https://github.com/jnhthomp/ClassNotes/blob/main/RubyOnRails/Notes2/3-IntroToRubyOnRails/classNotes.rb) on [my githb](https://github.com/jnhthomp) starting from '3-IntroToRubyOnRails'
This will outline how the project was created, how the database is structured,and how each part of the application works together.

## Optimizations

(Sorted by shorter to longer tasks)

* Add inegration tests (See tests to implement section)

* Use about page to show project info (use this README as a guide and add link to jumbotron)
	* Match look of page with article cards

* update require_same_user in controllers to create a new method called require_same_user_or_admin and potentially require_admin
  * this will make it so there are 4 levels of permissions that each page/action can have
    * unregistered users
    * registered users
    * registered users or admins
    * admins only

* move new logged_in? checks in controllers to before_actions

* edit 404 files for custom 404 pages? (public folder)

* Add functionality for an admin to make another user an admin (superuser?)

* Integrate ActionCable for a chat/messaging section

* Add user password requirements

* Check that all possible tests are present
  * Move as much out of setup and into test_helper as possible

* Get rid of bootstrap and replace with custom html/css/js

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



Tests to implement:
```
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
			list_articles_test.rb
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
    	delete_user_test.rb
    	
    system
      categories_test.rb
        Have:
          "updating a category"
          "destroying a category"
        Need:
          "creating a category
      articles_test.rb
        Need:
          "creating an article"
          "updating an article"
          "deleting an article"
      users_test.rb
        Need:
          "creating a user"
          "updating a user"
          "deleting a user"
      sessions_test.rb
        Need:
          "logging in a user"
          "logging out a user"
      navbar.rb
        Not going to write these out. Just make sure all the links work as expected and are clickable
```

## Resources
[The Complete Ruby on Rails Developer Course | Mashrur Hossain](https://www.udemy.com/share/101swc3@cCS4WWfsOKJUKdztJUfQSzLOScz48QRpSUl3gGSck2ewcS8hzH0dt-UoQzgIyZAm/)

## Other Examples:
Take a look at other examples from my <a href="https://jtdev.netlify.app/">portfolio</a> using the lessons learned from these classes:

**F1 Discord Bot** https://github.com/jnhthomp/f1-discord-bot

**Stock Based Social Network:** https://github.com/jnhthomp/finance-tracker

**Restaurant Web-Based Ordering System:** https://github.com/jnhthomp/practice-food-order-app