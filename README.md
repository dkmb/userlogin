# Simple User Login System

---
> A step by step recording of the creation of a simple user login system.

_* indicates that there is an associate code example_

---

## Iteration One

- rails new userlogin -T
- rails g resource user username:string password:string email:string
- rake db:migrate
- rails s
- users_controller.rb
  - add methods:  
      index, show, edit, update, new, create, destroy  
    add private method:
     
    ```ruby 
        def user_params  
          params.require(:user).permit(:username, :password, :email)  
        end  
    ```
- Create views templates in users directory:
  - edit, index, new, show
- Add index to routes.rb
  
  ```ruby
  root "users#index"
  ```
- add validations to models/user.rb (simple validation for now)
  
  ```ruby
    validates :username, presence: true  
    validates :password, presence: true  
    validates :email, presence: true  
  ```
- add _errors.html.erb template to views/shared*
- add _flashes.html.erb template to views/layouts*
- add simple _form.html.erb partial to views/users*
- include partial in edit and new templates:
  
  ```ruby
  <%= render 'form' %>
  ```
- add simple index.html.erb template to views/users*
- add simple show.html.erb template to views/users*
- add select all query to index action in users_controller.rb
  
  ```ruby
  @users = User.all
  ```
- add single item selection to show and edit actions in users_controller.rb
  
  ```ruby
  @user = User.find(params[:id])
  ```
- add update item to update action in users_controller.rb
  
  ```ruby
    @user = User.find(params[:id])  
    if @user.update(user_params)  
      redirect_to @user, notice: "User successfully updated!"  
    else  
      render :edit  
    end  
  ```
- add new item to new action in users_controller.rb
  
  ```ruby
  @user = User.new
  ```
- add create item to create action in users_controller.rb
  
  ```ruby
  @user = User.new(user_params)  
  if @user.save  
    redirect_to @user, notice: "User successfully created!"  
  else  
    render :new  
  end  
  ```
- add destroy item to destroy action in users_controller.rb
  
  ```ruby
  @user = User.find(params[:id])  
  @user.destroy  
  redirect_to users_url, alert: "User successfully deleted!"  
  ```
- create _nav.html.erb partial in views/layouts*
- add the call for our partial to views/layouts/application.html.erb
  - (this can go above the call to yield for now)  
    
    ```ruby
    <%= render "layouts/nav" %>
    ```

---
##Code

_errors.html.erb
---

```ruby
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


_flashes.html.erb
---

```ruby
<% flash.each do |key, value| %>
  <%= content_tag(:p, value, :class => "flash #{key}") %>
<% end %>
```


simple _form.html.erb
---

```ruby
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

simple index.html.erb
---

```ruby
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

simple show.html.erb
---

```ruby
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


_nav.html.erb
---

```ruby
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