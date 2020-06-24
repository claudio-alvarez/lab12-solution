# Lab 12 Starter Code

In this final lab assignment, you will enable access control and authentication
in the Ticket Shop application. The starter code you are provided with already
contains [Devise](https://github.com/heartcombo/devise) and 
[Cancancan](https://github.com/CanCanCommunity/cancancan) gems installed and 
partially configured.

#### Pre-requisites

* It is highly recommendable that you skim through [Devise's](https://github.com/heartcombo/devise)
and [Cancancan's](https://github.com/CanCanCommunity/cancancan) 'Getting Started'
guides, as these will walk you through the basics of both gems.
* Follow the non-graded steps carefully so that you understand how the application works in its
initial state.

#### Non-graded Steps

1. Have a look at the application layout at `app/views/layouts/application.html.erb`, and follow the
HTML comments that start with 'TODO', as this are (graded) steps you are expected to complete.
2. Take a look at the following event-related views: `app/views/events/{index.html.erb,show.html.erb,_event_tile.html.erb}`
You will also see TODO comments explaining what you are expected to complete.
3. Go to `app/controllers/application_controller.rb` and see the method `current_user`. Per each model
to which Devise is added, Devise dynamically enables several methods matching the respective model names, 
such as `current_admin`, and `current_customer`, as `Customer` and `Admin` are both models that are available
in the TicketShop application. Have look at the `Customer` and `Admin` models in order to see how Devise injects
its own logic. Also, you may see the latest migrations created by Devise automatically in the 
`db/migrate` directory. In order to operate with CanCanCan, it is necessary to
provide a `current_user` method that returns the model matching the current user, which is why such method is
implemented in the `ApplicationController` class.
4. Go to `app/controllers/orders_controller.rb`. You will need to investigate how to call
Devise's filter that is run before controller actions are executed, requiring the user
to be signed in. That is, before any action in that controller is executed, the user (customer)
must be authenticated. The solution to this is a one liner.
5. Inspect the file `app/models/ability.rb`. This is CanCanCan's central configuration file in the
TicketShop, which defines how resources are accessed by different kinds of users. You are required
to complete the `initialize` method in the `Ability` class, so that access to resources is properly
controlled per each kind of user. 
6. Inspect `app/controllers/shopping_cart_controller.rb` and see how the shopping cart cookie is saved depending
on who the logged-in user is. To allow many users to share the same web browser and each have their own shopping cart, 
the trick is to prepend the user's email address to the name of the cookie.  
7. Run the `rake routes` task and see the many routes that are enabled by Devise for `User` and `Admin`
resources. You may also want to check out the `config/routes.rb` file in order to see how Devise
has been configured for both models.
8. The sign-in page for administrators is accessible through the `admins/sign_in` path. You may sign in with the 
admin user `admin@ticketshop.com`, bt entering the password you set running the `rake admin:create_admin_user` task.
9. The sign-in route for customers is `customers/sign_in`. Use the rails console to see what (fake) users are
available. You may use any of them to sign in as a customer, with password `123123123`.
9. Finally, you may want to check out the task at `lib/tasks/create_admin_user.rake`. It is a good practice
to create a rake task that allows creating the admin user, instead of simply creating the user in the seeds 
file and carelessly exposing the default password in your sources' repository.

#### Graded Steps

1. [1.5 points] Complete the layout of the application, so that behavior of sign-in, sign-out, sign-up links works
properly. Also, the shopping cart must only be visible to signed-in customers. Non-registered users must only be able
to see events.
2. [2.0 points] Complete the Event view files described above, so that access control is possible. Only the admin
user should be able to create/edit `Event` and `TicketType` resources. On the other hand, only customers should
be able to purchase tickets. Also, non-registered users must see a link to the customer sign-in page when the list of 
available ticket types appears in the table listing them.
3. [.5 points] Enable Devise's filter at `app/controllers/orders_controller.rb` requiring the customer to log in before
accessing any actions provided by that controller.
4. [2.0 points] Complete `app/models/ability.rb` so that CanCanCan properly enforces access control to resources.
 
---

**Names:** (write your names here).

