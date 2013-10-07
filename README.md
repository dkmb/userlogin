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
- add [_errors.html.erb][1] template to app/views/shared*
- add [_flashes.html.erb][2] template to app/views/layouts*
- add [simple _form.html.erb][3] partial to app/views/users*
- include partial in edit and new templates:
  
  ```
  <%= render 'form' %>
  ```
- add [simple index.html.erb][4] template to app/views/users*
- add [simple show.html.erb][5] template to app/views/users*
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
- create [_nav.html.erb][6] partial in app/views/layouts*
- add the call for our partial to app/views/layouts/application.html.erb
  - (this can go above the call to yield for now)  
    
    ```
    <%= render "layouts/nav" %>
    ```

## Iteration Two
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
- create [styles.css.scss][7] in app/assets/stylesheets*
- create [index.css.scss][8] in app/assets/stylesheets*
- update [Gemfile][9] in root for future Heroku deployment*
- Download Modernizr (http://modernizr.com)
  - add Modernizr javascript to app/assets/javascripts
  - add Modernizr css to app/assets/stylesheets
- Download Normalize.css (http://necolas.github.io/normalize.css/)
  - add Normalize.css to app/assets/stylesheets
- create [_footer.html.erb][10] in app/views/layouts/*
- create [_header.html.erb][11] in app/views/layouts/*
- delete _nav.html.erb in app/views/layouts/
- create [_navigation.html.erb][12] in app/views/layouts/*
- create [_navlinks.html.erb][13] in app/views/layouts/*
- update [application.html.erb][14] in app/views/layouts/*
- create [index.html.erb][15] in app/views/users/*
- create a home controller
```
  rails g controller home -T
```
- update [home_controller.rb][16] in app/controllers*
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
##Code

[1]: *_errors.html.erb* (Iteration One)
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

[2]: *_flashes.html.erb* (Iteration One)
---

```
<% flash.each do |key, value| %>
  <%= content_tag(:p, value, :class => "flash #{key}") %>
<% end %>
```

[3]: *simple _form.html.erb* (Iteration One)
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

[4]: *simple index.html.erb* (Iteration One)
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

[5]: *simple show.html.erb* (Iteration One)
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

[6]: *_nav.html.erb* (Iteration One)
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

[7]: *styles.css.scss*
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

[8]: *index.css.scss* 
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

[9]: *Gemfile* 
```
  source 'https://rubygems.org'
  ruby '2.0.0'
  #ruby-gemset=railstutorial_rails_4_0

  gem 'rails', '4.0.0'

  group :development do
    gem 'sqlite3', '1.3.8'
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

[10]: *_footer.html.erb*
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

[11]: *_header.html.erb*
```
  <header id="userlogin-header">
    <div id="userlogin-title">
      <h1 class="userlogin-title-text"><%= link_to 'UserLogin', root_path, class: "userlogin-title-link" %></h1>
    </div>
  </header>
```

[12]: *_navigation.html.erb*
```
  <nav id="userlogin-navigation">
    <div class="userlogin-navigation-container">
      <%= render "layouts/navlinks" %>
    </div>
  </nav>
```

[13]: *_navlinks.html.erb*
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

[14]: *application.html.erb*
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

[15]: *index.html.erb*
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

[16]: *home_controller.rb*
```
  class HomeController < ApplicationController
  
    def about
    end
  
    def contact
    end
  
  end
```