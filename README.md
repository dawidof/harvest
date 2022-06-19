![Heroku](https://heroku-badge.herokuapp.com/?app=harvest-raporty)
https://harvest-raporty.herokuapp.com

## Dev
### Install
```bash
bundle
rake db:migrate
bin/dev
```
http://localhost:3000

## Harvest
### Create new oauth application
https://id.getharvest.com/oauth2/clients/new

![harvest_new_application](https://raw.githubusercontent.com/dawidof/harvest/master/public/images/harvest_new_application.png)
As follow
![harvest_created_application](https://raw.githubusercontent.com/dawidof/harvest/master/public/images/harvest_created_application.png)
## Heroku
Create heroku app and add envs from harvest and `ROOT_URL`
![Add envs to heroku](https://raw.githubusercontent.com/dawidof/harvest/master/public/images/heroku_envs.png)

Run migrations
![Run migrations](https://raw.githubusercontent.com/dawidof/harvest/master/public/images/heroku_migrate.png)
