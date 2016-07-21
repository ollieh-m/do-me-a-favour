## **Do Me A Favour** is a Rails Web App to help you and the people around you distribute chores fairly and efficiently.

#### (I'm developing it as a personal project to continue learning more about Rails.)

### CLANS

Signed-up users can create and join 'clans'. A clan is a group of users who can ask each other to do them a favour.
Users can join a clan by creating a new on, or by choosing an existing clan to join. 
Users can be members of any number of clans.

### FAVOURS

Signed-up users can post favours to any of the clans they have joined. 
They can also choose any other users who also benefit from the favour.
When a user does a favour for other users, they gain Thank You Points, and the users who benefited from the favour lose those Thank You Points.

### BIDS

Users can offer to do a favour if they are in one of the clans the favour was posted to.
They submit a bid with the number of Thank You Points they will gain if they do the favour.
Any user benefiting from the favour can accept a bid.

### COMPLETING A FAVOURS

When a bid has been accepted, no more bids can be submitted for the favour. 
Any user benefiting from the favour can then confirm when the favour has been completed.
At that point, the user who did the favour gains Thank You Points, and between them the users benefiting from the favour lose that number of Thank You Points.

### ADDITIONAL FUNCTIONALITY TO COME...
- Thank You Points limits: you cannot bid if by gaining the Thank You Points you would have more than 200 points, and you cannot bid if anyone benefiting from the favour would have fewer than 0 points. Everyone has to pull their weight!
- Deadlines: each favour has to be completed by a deadline. After the deadline bids cannot be made or accepted.
- Reasons: each bid can give reasons as well as a Thank You Points price which users benefiting can consider when they accept or reject a bid.

## How to try it

Clone this repo
Navigate into the new directory
Run bundle install
Run the following commands to create and migrate to a databasse and start the server:
- rake db:create
- rake db:migrate
- rails s
Visit localhost:3000 in your browser






