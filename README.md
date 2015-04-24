# redshell

Red Shell Solutions Inc.

Projeto de e-Governance COOOPEL - Poli/2015

Módulo de Serviços Estruturais
  - Responsável pelo controle de serviços de manutenção e atendimento ao usuário

Grupo de Trabalho
  - Diego Marques
  - Henrique Kano
  - Leonardo Berbare
  - Mi Che Li Lee

Repos úteis
  - Portal do Pikachu-PCS
  - Repositório do grupo no Google Drive

# Tasks
###Setting it up
[delayed_jobs_recurring](https://github.com/amitree/delayed_job_recurring) uses the db to store the jobs. So just run:
```
bundle install
rake db:migrate
```

and you are good to go
###Running it
To run it, run
```
rake periodic_tasks ~> not sure if it's necessary
rake jobs:work ~> the process will then wait for the jobs to come. For development, not sure what to do in production
```
###Changing it
If you gotta make any changes to the code, go to:
```
app/lib/periodic_tasks.rake ~> rakefile that schedule the task-creating processes
app/helpers/tasks_helper.rb ~> methods that do the task creating thingy
```
###References
To know more about
+ delayed_jobs_recurring: [http://thesource.amitree.com/2014/09/recurring-jobs-with-delayedjob.html](http://thesource.amitree.com/2014/09/recurring-jobs-with-delayedjob.html)
+ delayed_job: [http://blog.andolasoft.com/2013/04/4-simple-steps-to-implement-delayed-job-in-rails.html](http://blog.andolasoft.com/2013/04/4-simple-steps-to-implement-delayed-job-in-rails.html)
+ rakefiles: [http://jasonseifer.com/2010/04/06/rake-tutorial](http://jasonseifer.com/2010/04/06/rake-tutorial) 

#heroku for dummies
###Setting it up (rails)
Separate what you wanna run on develop and in production (Gemfile). For example:
```
group :development, :test do
  gem 'sqlite3'
  gem 'rspec', '~> 3.2.0'
  gem 'timecop'
  gem 'byebug', '~> 3.5.1'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
```

and finally, add the used ruby version at the Gemfile eof:
```
ruby [ruby_-v]
```

###Pushing it up (for future references, not for risky stuff)
```
heroku login --> login
```

if your application is ready:
```
heroku create [app_name]
```

push it to heroku:
```
git push heroku [git_banch_name_to_be_pushed]|master
```
(heroku only accepts a master branch)

instantiate a running app:
```
heroku ps:scale web=1
```
###Debugging it
```
heroku logs
```
it shows the servers messages (what it got, posted, etc)
