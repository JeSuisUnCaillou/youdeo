# YOUDEO

La plateforme de partage de contenus vidéos.

## Technical stuff

### Ruby version+
ruby 2.4.0p0 (2016-12-24 revision 57164)

### Important Gems
* [Bootstrap](https://github.com/twbs/bootstrap-rubygem) for the good looks
* [Devise](https://github.com/plataformatec/devise) and [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2) gems for the login


### Configuration
You need three environnement variables for google API to work :
* GOOGLE_API_KEY
* GOOGLE_CLIENT_ID
* GOOGLE_CLIENT_SECRET

In console, create or add in your `~/.bash_profile` the following lines :

```
export GOOGLE_API_KEY=AIzaSyCDbZ3Bz_AtVbgXrSHRRutM2bvXU8OvF8A
export GOOGLE_CLIENT_ID=134945960714-np8li9doq6r3m2tnjb9hvonl7qs6hi52.apps.googleusercontent.com
export GOOGLE_CLIENT_SECRET=OrI3Bm5nup1oxfT5Ta0koOoU
```


### Database creation & initialization

Run `rake db:migrate` to create the database

### How to run the test suite

Run `rake test` to run the test suite

### Services (job queues, cache servers, search engines, etc.)
None

### Deployment instructions

Don't forget to migrate the database and to create the environnement variables