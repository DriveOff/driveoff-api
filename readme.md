# Drive Off

An Omaha Startup Weekend 2016 project. This app rewards you for not driving and texting! Simply tell the app you have started driving, then don't touch your phone until you reach your destination, and earn points!

This application is the API that provides information to the front-end site.

## Local Installation and Setup

- You'll need Rails 4.2.7 and Ruby 2.3.1.
- You'll need ImageMagick installed (with Homebrew: `brew install imagemagick`)
- After you have cloned this repo:
  - `bundle` all the gems.
  - create your database: `rake db:create db:migrate`
  - to add starter data, add the seeds: `rake db:seed`
  - run the app: `rails s`

### .env example

This application uses the [dotenv-rails](https://github.com/bkeepers/dotenv) gem for environment variables.

You'll need to create a .env file in the root of the application and add your AWS credentials so you can upload user avatars and business logos in your local environment.

Here is an example that you can copy-paste and fill out:

```
AWS_ID=your_aws_id_here
AWS_SECRET=your_aws_secret_key_here
S3_BUCKET=your_aws_bucket_name_here
AWS_REGION=your_aws_region_name_here
```

## Models Overview

- **User**: There are three types of users: regular users, business admins (they can edit a business and create rewards for their business), and admins (do all the stuff). Users have many trips, many businesses, and many redemptions.
- **Trip**: Users go on trips, and as long as they don't touch their phone while driving, they earn points. We save records of these trips and points earned. Belongs to a user.
- **Business**: A business can provide rewards that the users can spend their points on. Has many rewards.
- **Reward**: An item that a user can claim with their points. Belongs to a business.
- **Redemption**: A record of a user's claimed reward. Belongs to the user and the reward, and also belongs to a business but indirectly (through the reward).

Models have handy [annotations](https://github.com/ctran/annotate_models) describing all their columns, which update every time you run `rake db:migrate`.

## Using the API

### Paths

The DriveOff API uses basic CRUD routes. Most of the above models have corresponding index, create, show, update, and delete paths. There are also routes for searching users, viewing a user's friends, adding and removing friends, login, and logout.

Currently the paths are:

| Verb   | URI Pattern                               | Description        |
|--------|-------------------------------------------|--------------------|
| GET    | /                                         | home               |
| GET    | /users(.:format)                          | users index        |
| GET    | /users/search(.:format)                   | search users       |
| POST   | /users(.:format)                          | create user        |
| GET    | /users/:id(.:format)                      | show user          |
| PUT    | /users/:id(.:format)                      | update user        |
| DELETE | /users/:id(.:format)                      | delete user        |
| GET    | /users/:id/friends(.:format)              | user friends index |
| PUT    | /users/:id/add_friend/:id2(.:format)      | add friend         |
| GET    | /users/:user_id/trips(.:format)           | trips index        |
| POST   | /users/:user_id/trips(.:format)           | create trip        |
| GET    | /users/:user_id/trips/:id(.:format)       | show trip          |
| PUT    | /users/:user_id/trips/:id(.:format)       | update trip        |
| DELETE | /users/:user_id/trips/:id(.:format)       | delete trip        |
| GET    | /users/:user_id/redemptions(.:format)     | redemptions index  |
| POST   | /users/:user_id/redemptions(.:format)     | create redemption  |
| GET    | /users/:user_id/redemptions/:id(.:format) | show redemption    |
| DELETE | /users/:user_id/redemptions/:id(.:format) | delete redemption  |
| GET    | /businesses(.:format)                     | businesses index   |
| POST   | /businesses(.:format)                     | create business    |
| GET    | /businesses/:id(.:format)                 | show business      |
| PUT    | /businesses/:id(.:format)                 | update business    |
| DELETE | /businesses/:id(.:format)                 | delete business    |
| GET    | /rewards(.:format)                        | rewards index      |
| POST   | /rewards(.:format)                        | create reward      |
| GET    | /rewards/:id(.:format)                    | show reward        |
| PUT    | /rewards/:id(.:format)                    | update reward      |
| DELETE | /rewards/:id(.:format)                    | delete reward      |
| POST   | /login(.:format)                          | login              |
| DELETE | /logout(.:format)                         | logout             |

All index paths, as well as the search path and friends path, return paginated results with 20 results per page. To proceed to the next page, make a GET request with a page parameter.

```
https://driveoff.herokuapp.com/users/1/trips?page=2
```

### Authentication

To authenticate, your application must make a POST request to the `/login` path with email and password parameters for the user.

```
https://driveoff.herokuapp.com/login?email=user@example.com&password=yourpasswordhere
```

Upon successfully logging in, the API's response will contain user information and most importantly, an authorization token that your application will need to continue using the API as the user. `yourtokenhere` will be an actual token.

```json
{
  "id": 1,
  "email": "user@example.com",
  "token": "yourtokenhere",
  "name": "Regular User",
  "points": 38,
  "spendable_points": 28,
  "points_this_week": 38,
  "role": "user",
  "avatar": null,
  "city": "Omaha",
  "state": "NE",
  "zip_code": 68144,
  "birthday": "1985-01-01",
  "age": 31,
  "gender": "male",
  "custom_gender": null,
  "pronouns": null,
  "created_at": "2016-10-20T01:46:38.129Z"
}
```

### Authorization

Many paths require the user to be authorized to view them. For example, a regular user can see their own trips but not other user's trips. Specific policies can be found in `/app/policies/`.

If your application attempts to view a page without the proper authorization, you will receive a 401 Unauthorized error.

To provide the correct authorization, make a request to the desired path with the user's authorization token and email in the header. Remember to replace `yourtokenhere` with your actual token.

```
Authorization:Token token="yourtokenhere", email="user@example.com"
```

### Parameters

These routes accept additional parameters. Parameters marked with an asterisk are required.

#### Users

##### *Search*
- **query**: string, for searching through users emails. Matches the start of emails.

`/users/search?query=katie`

##### *Create User*
- **email***: string
- **password***: string
- **password_confirmation***: string, must match password
- **name***: string
- **role**: string, if not provided the default is user
  - user
  - business_admin
  - admin
- **avatar**: string, URL to avatar image
- **city***: string
- **state***: string, must be the two-letter state abbreviation. See [postal_abbreviations.rb](https://github.com/DriveOff/driveoff-api/blob/master/app/models/concerns/postal_abbreviations.rb) for a full list of valid state abbreviations. We suggest providing users with a dropdown to avoid user error.
- **zip_code**: integer, must be 5 digits or blank
- **gender***: string, must be included in:
  - male
  - female
  - undisclosed
  - custom
- **custom_gender**: string, required if gender is custom. The user can type any identity.
- **pronouns**: string, required if gender is custom, must be included in:
  - masculine
  - feminine
  - neutral

`/users?email=user2@example.com&password=yourpassword&password_confirmation=yourpassword&name=John%20Doe&city=Omaha&state=NE&gender=1`

##### *Update User*

Same as create user, except no fields are required, unless the user is changing their password, then they must also fill out the password_confirmation field.

- **user_id***: integer, the ID of the user being updated

`/users/1?city=Bellevue`

##### *Delete User*
- **user_id***

#### Trips

##### *Create Trip*
- **user_id***: integer, in the path, the user that owns the trip
- **distance***: decimal (up to 1 place after the decimal point), the distance traveled in miles
- **time***: integer, the time traveled in minutes

`/users/1/trips?distance=5.5&time=14`

##### *Update Trip*
- **user_id***
- **id***: integer, the ID of the trip being updated
- **distance**
- **time**

`/users/1/trips/1?distance=5.5&time=14`

##### *Delete Trip*
- **user_id***
- **id***

#### Businesses

##### *Create Business*
- **name***: string, the name of the business
- **user\_id**: integer, the user who will be the business\_admin for this business

`/businesses?name=Cats%20In%20Hats&user_id=1`

##### *Update Business*

Same as create business, except no fields are required.

##### *Delete Business*

- **id***

#### Rewards

##### *Create Reward*
- **title*** - string, name of the reward
- **description*** - text, details about the reward
- **cost*** - integer, how many points the user must spend to claim the reward
- **business_id*** - integer, the ID of the business that owns the reward

`rewards?title=One%20Free%20Hat&description=One%20free%20hat%20from%20your%20local%20store&cost=10`

##### *Update Reward*

Same as create reward, except no fields are required.

##### *Delete Reward*
- **id***

#### Redemptions

##### *Create Redemption*
- **user_id***: integer, in the path, the user that owns the redemption
- **reward_id***: integer, the ID of the reward from which the redemption was created

`users/1/redemptions?reward_id=1`

##### *Destroy Redemption*
- **id***
