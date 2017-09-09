# YOUDEO

La plateforme de partage de contenus vidéos.

## Technical stuff

### Ruby version+
ruby 2.4.0p0 (2016-12-24 revision 57164)

### Important Gems
* [Bootstrap](https://github.com/twbs/bootstrap-rubygem) for the good looks
* [Devise](https://github.com/plataformatec/devise) and [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2) gems for the login
* This [Youtube API gem](https://github.com/Fullscreen/yt) to poke youtube datas. You might also need [this Stackoverflow post](https://stackoverflow.com/questions/10827920/not-receiving-google-oauth-refresh-token) with the way to get a new refresh token for the google api. Useful when testing.

### Configuration
You need three environnement variables for google API to work. Get them from Google in [the Developer Console](https://console.developers.google.com/)

To keep your environnement variables up, create or add in your `~/.bash_profile` the following lines :

```
export GOOGLE_API_KEY=...
export GOOGLE_CLIENT_ID=...
export GOOGLE_CLIENT_SECRET=...
```


### Database creation & initialization

Run `rake db:migrate` to create the database

### How to run the test suite

Run `rake test` to run the test suite

* [Guide for omniauth integration testing](https://github.com/omniauth/omniauth/wiki/Integration-Testing)

### Services (job queues, cache servers, search engines, etc.)
None

### Deployment instructions

Don't forget to migrate the database and to create the environnement variables