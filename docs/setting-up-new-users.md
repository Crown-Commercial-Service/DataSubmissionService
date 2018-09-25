# Setting up new users

At present adding new users to Report MI is a three stage process:

  1. Add the users to Auth0
  2. Add Users record to the frontend application, mapping to the Auth0 user ID
  3. Add Membership records in the API, mapping the User IDs in the frontend
     application to the supplier IDs in the API

(Note: there is technically a step 0, which is to add the users' suppliers to
the API. For an example of how to do that, see this [data migration for adding suppliers].)

Steps 1 and 2 can be performed using the `Auth0AuthenticatedUser` utility
class.

Below is an example Ruby script demonstrating its use. It assumes the following:

- There is a CSV file containing the user details with headers: Supplier Name,
  User Name, Email
- There is a hash mapping supplier names to their IDs in the API, as output by
  the example [data migration for adding suppliers]
- AUTH0 environment variables are set, including one called `AUTH0_API_TOKEN`
  that contains a valid API token. One can be acquired from "API Explorer" tab
  in the API section of Auth0.

```ruby
require 'auth0'
require 'csv'

# set this based on the output from the supplier data migration that is run on the API
SUPPLIER_NAME_TO_ID_MAP = { "Supplier Name" => "UUID_FOR_SUPPLIER",... }
# CSV file containing: Supplier Name,User Name,Email
USERS_CSV_PATH = Rails.root.join('tmp', 'users.csv')

auth0_client = Auth0Client.new(
  client_id: ENV['AUTH0_CLIENT_ID'],
  domain: ENV['AUTH0_DOMAIN'],
  token: ENV['AUTH0_API_TOKEN'], # This needs to be generated/acquired from Auth0
  api_version: 2
)

CSV.read(USERS_CSV_PATH, headers: true, header_converters: :symbol).each do |row|
  user_name = row.fetch(:user_name)
  email = row.fetch(:email)
  supplier_name = row.fetch(:supplier_name)
  supplier_id = SUPPLIER_NAME_TO_ID_MAP.fetch(supplier_name)

  auth0_authenticated_user = Auth0AuthenticatedUser.new(auth0_client, user_name, email, supplier_name, supplier_id)
  user = auth0_authenticated_user.create!

  puts "Membership.create!(user_id: '#{user.id}', supplier_id: '#{supplier_id}')"
```

Note that this script also outputs Rails code that can be run on the API
console to complete Step 3, i.e. create the memberships mapping the user back
to their supplier.

[data migration for adding suppliers]:https://github.com/dxw/DataSubmissionServiceAPI/tree/develop/db/data_migrate/20180924143116_add_october_suppliers.rb
