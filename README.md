# Simple User Login System

---
> A step by step recording of the creation of a simple user login system. This is not considered a tutorial for developers new to Ruby on Rails. In fact, it isn't much of a tutorial at all. It might be considered a guide for Rails developers that have just completed a few introductory tutorials. As someone that is new to Rails, I thought it would be helpful to document the creation of an app. I chose this sample login app because I need a login system for a closed source project I am working on. 

_* indicates that there is an associated code example_

---

## Iteration One

> The goal here is to get our application up and running. We will do a few things here that wouldn't make sense in a real application (list users with their passwords). But the idea is to get a system up and running as quickly as possible. 

- rails new userlogin -T
  - Creates a new rails app (without default testing suite), navigate to the new directory once it is created
- rails g resource user username:string password:string email:string
  - Create a new resource which includes the model, view, controller, and routes
- rake db:migrate
  - Creates the database
- rails s
  - Starts the local rails server (default at localhost:3000)
- app/controllers/users_controller.rb
  - add methods:  
      index, show, edit, update, new, create, destroy  
  - add private method:
     
    ```ruby 
        def user_params  
          params.require(:user).permit(:username, :password, :email)  
        end  
    ```
- Create view templates in app/views/users directory:
  - edit, index, new, show
- Add index to config/routes.rb
  
  ```ruby
  root "users#index"
  ```
- add validations to app/models/user.rb (simple validation for now)
  
  ```ruby
    validates :username, presence: true  
    validates :password, presence: true  
    validates :email, presence: true  
  ```
- add [_errors.html.erb](#_errorshtmlerb) template to app/views/shared*
- add [_flashes.html.erb](#_flasheshtmlerb) template to app/views/layouts*
- add [simple _form.html.erb](#simple-_formhtmlerb) partial to app/views/users*
- include partial in edit and new templates:
  
  ```
  <%= render 'form' %>
  ```
- add [simple index.html.erb](#simple-indexhtmlerb) template to app/views/users*
- add [simple show.html.erb](#simple-showhtmlerb) template to app/views/users*
- add select all query to index action in app/controllers/users_controller.rb
  
  ```ruby
  @users = User.all
  ```
- add single item selection to show and edit actions in app/controllers/users_controller.rb
  
  ```ruby
  @user = User.find(params[:id])
  ```
- add update item to update action in app/controllers/users_controller.rb
  
  ```ruby
    @user = User.find(params[:id])  
    if @user.update(user_params)  
      redirect_to @user, notice: "User successfully updated!"  
    else  
      render :edit  
    end  
  ```
- add new item to new action in app/controllers/users_controller.rb
  
  ```ruby
  @user = User.new
  ```
- add create item to create action in app/controllers/users_controller.rb
  
  ```ruby
    @user = User.new(user_params)  
    if @user.save  
      redirect_to @user, notice: "User successfully created!"  
    else  
      render :new  
    end  
  ```
- add destroy item to destroy action in app/controllers/users_controller.rb
  
  ```ruby
  @user = User.find(params[:id])  
  @user.destroy  
  redirect_to users_url, alert: "User successfully deleted!"  
  ```
- create [_nav.html.erb](#_navhtmlerb) partial in app/views/layouts*
- add the call for our partial to app/views/layouts/application.html.erb
  - (this can go above the call to yield for now)  
    
    ```
    <%= render "layouts/nav" %>
    ```

## Iteration Two
---
> Design and Implementation. Many of the steps here have little to do with writing Rails specific code. However, this outlines how assets are managed in a Rails application. We also create a new controller to hold static pages like about and contact.

---

> The sample app is now deployed to http://radiant-waters-7292.herokuapp.com and will be updated along with this repo

---

- design mockup can be found in app/assets/images/design
  - available as both .psd (for editing) and .png (for quick reference)
- create _colors.css.scss in app/assets/stylesheets

  ```
    $darkest_color: #1d3a4f;
    $dark_color: #274d69;
    $light_color: #3a739b;
    $lightest_color: #4c98cf;
    $header_color: #333333;
    $body_color: #efefef;
    $content_color: #ffffff;
  ```
  
- create [styles.css.scss](#stylescssscss) in app/assets/stylesheets*
- create [index.css.scss](#indexcssscss) in app/assets/stylesheets*
- update [Gemfile](#gemfile) in root for future Heroku deployment*
- Download Modernizr (http://modernizr.com)
  - add Modernizr javascript to app/assets/javascripts
  - add Modernizr css to app/assets/stylesheets
- Download Normalize.css (http://necolas.github.io/normalize.css/)
  - add Normalize.css to app/assets/stylesheets
- create [_footer.html.erb](#_footerhtmlerb) in app/views/layouts/*
- create [_header.html.erb](#_headerhtmlerb) in app/views/layouts/*
- delete _nav.html.erb in app/views/layouts/
- create [_navigation.html.erb](#_navigationhtmlerb) in app/views/layouts/*
- create [_navlinks.html.erb](#_navlinkshtmlerb) in app/views/layouts/*
- update [application.html.erb](#applicationhtmlerb) in app/views/layouts/*
- create [index.html.erb](#indexhtmlerb) in app/views/users/*
- create a home controller

```
  rails g controller home -T
```

- update [home_controller.rb](#home_controllerrb) in app/controllers*
- create about.html.erb in app/views/home/

```
  <h2>About</h2>
```

- create contact.html.erb app/views/home/

```
  <h2>Contact</h2>
```

- update config/routes.rb

```
  Userlogin::Application.routes.draw do
    root 'users#index'
    resources :users
    get 'about' => 'home#about'
    get 'contact' => 'home#contact'
  end
```

## Iteration Three
---

> Testing

- Install RSpec

```
  rails generate rspec:install
```

- Run migrations for the testing environment

```
  rake db:migrate RAILS_ENV=test
```

- Write a simple test for our new static pages
  - create a "features" folder in the spec directory
  - create [home_spec.rb](#home_specrb) in spec/features*
  
---

> Tests like this one provide little value in a real world scenario. The results of this test could easily be checked by manually going to the page. It is more appropriate to use tests for dynamic content. Here it is used more to make sure RSpec is up and running.

- Next we will create tests for creating, deleting, editing, showing, and listing users
  - create a new folder and name it "support" in the spec directory
    - create [user_attributes.rb](#user_attributesrb) in spec/support
  - create [create_user_spec.rb](#create_user_specrb) in spec/features*
  - create [delete_user_spec.rb](#delete_user_specrb) in spec/features*
  - create [edit_user_spec.rb](#edit_user_specrb) in spec/features*
  - create [list_user_spec.rb](#list_user_specrb) in spec/features*
  - create [show_user_spec.rb](#show_user_specrb) in spec/features*
- Next we will create a test for our model. This will test validation on our form
  - create a new folder and name it "models" in the spec directory
    - create [user_spec.rb](#user_specrb) in spec/models

- run RSpec on the application

```
  rspec
```

> This second set of tests has provided us with testing of dynamic content and provided us with a framework to expand our application on. From here we will enhance data entry and form validation. 


---
##Code

###*_errors.html.erb* 
(Iteration One)

---

```
  <% if object.errors.any? %>
  <section id="errors">
    <header>
      <h2>
        Oops! The <%= object.class.name.titleize.downcase %> could not be saved.
      </h2>
      <h3>
        Please correct the following <%= pluralize(object.errors.count, "error") %>:
      </h3>
    </header>
    <ul>
      <% object.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </section>
  <% end %>
```

###*_flashes.html.erb*
(Iteration One)

---

```
  <% flash.each do |key, value| %>
    <%= content_tag(:p, value, :class => "flash #{key}") %>
  <% end %>
```

###simple _form.html.erb* 
(Iteration One)

---

```
  <%= form_for(@user) do |f| %>
    <%= render "shared/errors", object: @user %>
    <fieldset>
      <p>
        <%= f.label :username %>
        <%= f.text_field :username, autofocus: true %>
      </p>
      <p>
        <%= f.label :password %>
        <%= f.text_field :password %>
      </p>
      <p>
        <%= f.label :email %>
        <%= f.text_field :email %>
      </p>
      <p>
        <%= f.submit %>
        <%= link_to "Cancel", users_path %>
      </p>
    </fieldset>
  <% end %>
```

###*simple index.html.erb* 
(Iteration One)

---

```
  <ul>
    <% @users.each do |user| %>
      <li>
        <article>
          <header>
            <h2><%= link_to(user.username, user) %></h2>
          </header>
          <p>
            Password: <%= user.password %>
          </p>
          <p>
            Email: <%= user.email %>
          </p>
        </article>
      </li>
    <% end %>
  </ul>
```

###simple show.html.erb* 
(Iteration One)

---

```
  <article>
    <header>
      <h1><%= @user.username %></h1>
    </header>
  
    <h3>Password</h3>
    <p>
      <%= @user.password %>
    </p>
  
    <h3>Email Address</h3>
    <p>
      <%= @user.email %>
    </p>
  
    <footer>
      <nav>
        <%= link_to "Edit", edit_user_path(@user) %>
        <%= link_to "Delete", @user, method: :delete, data: { confirm: 'Are you sure?' } %>
      </nav>
    </footer>
  </article>
```

###*_nav.html.erb* 
(Iteration One)

---

```
  <nav>
    <ul>  
      <li>
        <%= link_to "All Users", users_path %>
      </li>
      <li>
        <%= link_to 'Add New User', new_user_path %>
      </li>
    </ul>
  </nav>
```
---

###*styles.css.scss* 
(Iteration Two)

---

```
  @import "colors";

  body {
  	background-color: $light_color;
  	color: $header_color;
  }

  /*
   * Header
   */
  #userlogin-header { 
  	height: 100px;
  	background-color: $header_color;
  }
  #userlogin-title {
  	max-width: 1000px;
  	width: 100%; 
  	margin: 0px auto;
  }
  .userlogin-title-text {
  	margin: 0px;
  	padding: 0px 0px 0px 10px;
  	line-height: 100px;
  }
  .userlogin-title-link:link, .userlogin-title-link:visited {
  	color: #fff;
  	text-decoration: none;
  }


  /*
   * Menu
   */
  .userlogin-menu-list {
  	padding: 0px;
  	margin: 0px;
  }
  .userlogin-menu-list-item {
  	display: inline;	
  	padding-right: 10px;
  }
  .userlogin-menu-link:link, .userlogin-menu-link:visited {
  	color: #fff;
  	text-decoration: none;
  }

  /*
   * Top Navigation
   */
  #userlogin-navigation {
  	height: 50px;
  	line-height: 50px;
  	background-color: $dark_color;
  	padding-left: 10px;
  }
  .userlogin-navigation-container {
  	max-width: 1000px;
  	width: 100%; 
  	margin: 0px auto;
  }
  .userlogin-navigation-container .userlogin-menu-link:hover,
  .userlogin-navigation-container .userlogin-menu-link:active {
  	text-decoration: underline;
  	color: $lightest_color;
  }

  /*
   * Content
   */
  #userlogin-container {
  	background-color: #efefef;
  }
  #userlogin-content {
  	max-width: 1000px;
  	width: 100%; 
  	margin: 0px auto;
  	padding: 20px 0px 20px 0px;
  }

  /*
   * Footer
   */
  #user-footer {
  	background-color: $light_color;
  }
  .user-footer-navigation {
  	max-width: 1000px;
  	width: 100%;
  	margin: 0px auto;
  	text-align: center;
  	padding-top: 20px;
  	text-transform: uppercase;
  	font-size: .8em;
  }
  .user-footer-navigation .userlogin-menu-link:hover,
  .user-footer-navigation .userlogin-menu-link:active {
  	text-decoration: underline;
  	color: $darkest_color;
  }
  .user-footer-copyright {
  	max-width: 1000px;
  	width: 100%; 
  	margin: 0px auto;
  	color: #fff;
  	text-align: center;
  	font-size: .8em;
  	padding: 20px 0px 20px 0px;
  }
  .user-footer-copyright-link:link, .user-footer-copyright-link:visited {
  	color: #fff;
  	text-decoration: underline;
  }
  .user-footer-copyright-link:hover, .user-footer-copyright-link:active {
  	color: $darkest_color;
  }
```

###*index.css.scss* 
(Iteration Two)

---

```
  @import "colors";

  /*
   * Login Box
   */
  .userlogin-loginbox {
  	text-align: center;
  }
  .userlogin-loginbox-list {
  	margin: 0px;
  	padding: 0px;
  }
  .userlogin-loginbox-item {
  	list-style-type: none;
  	padding: 10px;
  }
  .userlogin-loginbox-link:link, .userlogin-loginbox-link:visited {
  	display: inline-block;
  	height: 100px;
  	width: 300px;
  	background-color: $dark_color;
  	line-height: 100px;
  	color: #fff;
  	text-decoration: none;
  	text-transform: uppercase;
  	font-size: 2em;
  	border: 1px solid $darkest_color;
  }

  /*
   * User Listing
   */
  .userlogin-user-listing {
  	border: 2px solid	#ccc;
  	padding: 20px;
  	text-align: center;
  	background-color: #fff;
  	width: 250px;
  	margin: 0px auto;
  }
  .userlogin-user-list {
  	text-align: left;
  }
  .userlogin-user-item {
  	list-style-type: none;
  	margin: 0px;
  	padding: 0px;
  }
  .userlogin-user-item-article {
  	padding: 5px 0px 5px 0px;
  }
  .userlogin-user-listing-title {
  	padding: 0px;
  	margin: 0px;
  }
  .userlogin-user-listing-link:link, .userlogin-user-listing-link:visited {
  	color: #000;
  	text-decoration: none;
  }
  .userlogin-user-listing-email {
  	font-style: italic;
  	margin: 0px;
  	color: 
  	#999;
  	font-size: .9em;
  }
```

###*Gemfile* 
(Iteration Two)

---

```
  source 'https://rubygems.org'
  ruby '2.0.0'
  #ruby-gemset=railstutorial_rails_4_0

  gem 'rails', '4.0.0'

  group :development, :test do
    gem 'sqlite3', '1.3.8'
    gem 'rspec-rails', '2.13.1'
  end

  group :test do
    gem 'selenium-webdriver', '2.35.1'
    gem 'capybara', '2.1.0'
  end

  gem 'sass-rails', '4.0.0'
  gem 'uglifier', '2.1.1'
  gem 'coffee-rails', '4.0.0'
  gem 'jquery-rails', '3.0.4'
  gem 'turbolinks', '1.1.1'
  gem 'jbuilder', '1.0.2'

  group :doc do
    gem 'sdoc', '0.3.20', require: false
  end

  group :production do
    gem 'pg', '0.15.1'
    gem 'rails_12factor', '0.0.2'
  end
```

###*_footer.html.erb* 
(Iteration Two)

---

```
  <footer id="user-footer">
    <div class="user-footer-navigation">
      <%= render "layouts/navlinks" %>
    </div>
    <p class="user-footer-copyright">  
      Copyright &copy; 2013 <a href="http://www.mitchellshelton.com" title="Visit mitchellshelton.com" class="user-footer-copyright-link">Mitchell Shelton</a>
    </p>  
  </footer>
```

###*_header.html.erb* 
(Iteration Two)

---

```
  <header id="userlogin-header">
    <div id="userlogin-title">
      <h1 class="userlogin-title-text"><%= link_to 'UserLogin', root_path, class: "userlogin-title-link" %></h1>
    </div>
  </header>
```

###*_navigation.html.erb* 
(Iteration Two)

---

```
  <nav id="userlogin-navigation">
    <div class="userlogin-navigation-container">
      <%= render "layouts/navlinks" %>
    </div>
  </nav>
```

###*_navlinks.html.erb* 
(Iteration Two)

---

```
  <ul class="userlogin-menu-list">  
    <li class="userlogin-menu-list-item">
      <%= link_to "Home", root_path, class: "userlogin-menu-link" %>
    </li>
    <li class="userlogin-menu-list-item">
      <%= link_to 'Register', new_user_path, class: "userlogin-menu-link" %>
    </li>
    <li class="userlogin-menu-list-item">
      <%= link_to "Login", root_path, class: "userlogin-menu-link" %>
    </li>
    <li class="userlogin-menu-list-item">
      <%= link_to "About", about_path, class: "userlogin-menu-link" %>
    </li>
    <li class="userlogin-menu-list-item">
      <%= link_to "Contact", contact_path, class: "userlogin-menu-link" %>
    </li>
  </ul>
```

###*application.html.erb* 
(Iteration Two)

---

```
  <!DOCTYPE html>
  <html>
  <head>
    <title>Userlogin</title>
    <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
    <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
    <%= csrf_meta_tags %>
  </head>
  <body>
  <%= render "layouts/header" %>
  <%= render "layouts/navigation" %>
  <div id="userlogin-container">
    <div id="userlogin-content">
      <%= yield %>
    </div>
  </div>
  <%= render "layouts/footer" %>

  </body>
  </html>
```

###*index.html.erb* 
(Iteration Two)

---

```
  <div class="userlogin-loginbox">
    <ul class="userlogin-loginbox-list">
      <li class="userlogin-loginbox-item">
        <%= link_to "Register", new_user_path, class: "userlogin-loginbox-link"  %>
      </li>
      <li class="userlogin-loginbox-item">
        <%= link_to "Login", root_path, class: "userlogin-loginbox-link" %>
      </li>
    </ul>
  </div>
  <div class="userlogin-user-listing">
    <ul class="userlogin-user-list">
      <% @users.each do |user| %>
        <li class="userlogin-user-item">
          <article class="userlogin-user-item-article">
            <h2 class="userlogin-user-listing-title">
              <%= link_to(user.username, user, class: "userlogin-user-listing-link") %>
            </h2>
            <p class="userlogin-user-listing-email">
              <%= user.email %>
            </p>
          </article>
        </li>
      <% end %>
    </ul>
  </div>
```

###*home_controller.rb* 
(Iteration Two)

---

```
  class HomeController < ApplicationController

    def about
    end
  
    def contact
    end
  
  end
```

###*home_spec.rb* 
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Static pages" do

    describe "About page" do
      it "should have the content 'Sample App'" do
        visit '/about'
        expect(page).to have_content('About')
      end    
    end
  
    describe "Contact page" do
      it "should have the content 'Sample App'" do
        visit '/contact'
        expect(page).to have_content('Contact')
      end    
    end
  
  end
```

###*user_attributes.rb*
(Iteration Three)

---

```
  def user_attributes(overrides = {})
    {
      username: "Timuser",
      password: "4321",
      email: "tim@user.com"
    }.merge(overrides)
  end
```

###*create_user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Creating a user" do
    it "saves the user and shows the user details" do
      visit users_url

      find('.userlogin-loginbox-list').click_link 'Register'

      expect(current_path).to eq(new_user_path)

      fill_in "Username", with: "Timuser"
      fill_in "Password", with: "4321"
      fill_in "Email", with: "tim@user.com"

      click_button 'Create User'

      expect(current_path).to eq(user_path(User.last))

      expect(page).to have_text('Account successfully created!')
    end

    it "does not save the user if it is invalid" do
      visit new_user_url

      expect {
        click_button 'Create User'
      }.not_to change(User, :count)

      expect(page).to have_text('error')
    end
  end
```

###*delete_user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Deleting a user" do
    it "destroys the user and shows the user listing" do
      user = User.create(user_attributes)

      visit user_path(user)

      click_link 'Delete'

      expect(current_path).to eq(users_path)
      expect(page).not_to have_text(user.username)
      expect(page).to have_text('Account successfully deleted!')
    end
  end
```

###*edit_user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Editing a user" do

    it "updates the user and shows the user's updated details" do
      user = User.create(user_attributes)

      visit user_url(user)

      click_link 'Edit'

      expect(current_path).to eq(edit_user_path(user))

      expect(find_field('Username').value).to eq(user.username)

      fill_in 'Username', with: "Updated User Name"

      click_button 'Update User'

      expect(current_path).to eq(user_path(user))

      expect(page).to have_text('Updated User Name')
      expect(page).to have_text('Account successfully updated!')
    end

    it "does not update the user if it's invalid" do
      user = User.create(user_attributes)

      visit edit_user_url(user)

      fill_in 'Username', with: " "

      click_button 'Update User'

      expect(page).to have_text('error')
    end

  end
```

###*list_user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Viewing the list of users" do

    it "shows the users stored in the database" do
      userA = User.create(username: "Bob",
                                password: "abcd",
                                email: "bob@stuff.com")

      userB = User.create(username: "Tom",
                                password: "p@ssw0rd",
                                email: "tom@stuff.com")

      userC = User.create(username: "Richard",
                                password: "1234",
                                email: "richard@stuff.com")

      visit users_url

      expect(page).to have_text(userA.username)
      expect(page).to have_text(userB.username)
      expect(page).to have_text(userC.username)

      expect(page).to have_text("bob@stuff.com")
      expect(page).to have_text("tom@stuff.com")
      expect(page).to have_text("richard@stuff.com")
    end

  end

```

###*show_user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "Viewing an individual user" do

    it "shows the user's details" do
      user = User.create(user_attributes(username: "Tom", password: "1234", email: "tom@stuff.com"))

      visit user_url(user)

      expect(page).to have_text(user.username)
      expect(page).to have_text(user.password)
      expect(page).to have_text(user.email)
    end

  end
```

###*user_spec.rb*
(Iteration Three)

---

```
  require 'spec_helper'

  describe "A project" do
  
    it "requires a username" do
      user = User.new(username: "")

      expect(user.valid?).to be_false
      expect(user.errors[:username].any?).to be_true
    end
  
    it "requires a password" do
      user = User.new(password: "")

      expect(user.valid?).to be_false
      expect(user.errors[:password].any?).to be_true
    end
  
    it "requires a email" do
      user = User.new(email: "")

      expect(user.valid?).to be_false
      expect(user.errors[:email].any?).to be_true
    end
  
  end
```