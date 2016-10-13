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
