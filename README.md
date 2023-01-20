# README

__Note__: PostMan collection (with sample response) is also added here.


Change the creds in the database.yml
run the application by executing the following command 

```ruby
rails db:create db:migrate
rails s
```

__Sample Request__

#### POST
curl -X POST localhost:3000/slots -d 'slot[start_time]=01:00&slot[end_time]=02:00&slot[total_capacity]=6'

#### GET
curl localhost:3000/slots

#### GET 
curl localhost:3000/slots/:id