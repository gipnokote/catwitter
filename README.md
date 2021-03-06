CATwitter
======

CATwitter is an implementation of tech task for Autobutler company.
This is a very basic twitter clone.

The working instance can be seen [here](http://catwitter.misterodds.com/) (not guaranteed to be there forever)

Requirements
------------

CATwitter relies on [Ruby on Rails framework](http://rubyonrails.org/) and the following gems:
* [Devise](https://github.com/plataformatec/devise): configurable authentication system
* [Bootstrap](http://getbootstrap.com/): popular CSS framework
* [HAML](https://github.com/haml/haml): templating engine
* [SQLite3](http://rubygems.org/gems/sqlite3): simple database engine that stores the files locally (any other DB engine could be used)
* [acts_as_commentable](https://github.com/jackdempsey/acts_as_commentable): a gem for comments

Installation
------------

Installation is simple. First step is to checkout the repo:

```console
git clone git@github.com:gipnokote/catwitter.git
```

Then the dependencies have to be installed:

```console
bundle install
```

SQLite gem might require to install some libs which may vary depending on the server system.

Finally, the database has to be created:

```console
rake db:create
rake db:migrate
```

Login details
-------------

If you don't want to register a user (although it's very easy and doesn't require email),
you can use this account: Wolverine / 123

Task description
----------------

```
I would like to see how you’d build the following Twitter thingy in Rails:
 
Build an app, where a user can log in and perhaps edit his account (username, real name etc.)
 
The following features needs to be available to the user:
 
  - Add friend (from other users)
  - Remove friend (from friend list)
 
  - Post a message
  - Show all messages from friends
 
  - Ability to lookup another user and see his posts
 
You might add the following as well:
 
  - A user can block another user, so that other user can’t see his posts or add him as friend
  - Users can comment on posts
```