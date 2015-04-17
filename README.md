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
