# README

NOTE: I couldn't understand the concept of capacity in the question, I have done the logic for slots only

Change the creds in the database.yml
run the application by executing the following command 

rails db:create db:migrate
rails s


sample request

POST
curl -X POST localhost:3000/slots -d 'slot[start_time]=01:00&slot[end_time]=02:00&slot[total_capacity]=15'

GET
curl localhost:3000/slots

GET 
curl localhost:3000/slots/:id