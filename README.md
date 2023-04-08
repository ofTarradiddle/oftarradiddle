# Reddit Clone

Responsive Full Stack Reddit Clone - Works on Android, iOS & Web! 

Self and group stats need better layouts 
when I leave study stats I should go to study home page 
logging into home page should be easier 


TODO
  Add analytics for inference--
    interactive time chart with filter - sort analytics by time 
    datatable 
    -correlation matrix
    -decision tree 
    Add description of study on input page, and create page under field names 
    -Add option for timeseries to single variable for scale 

  View--
    profile doesnt show posts (need index), also post page comments doesnt show comments(also needs index), + screen is off sometimes
    -when done with data entry, go back to study page
    -what is wrong with the search

  Ease for accesing home page--
    add sign in with email, 
    -logging in doesnt bring to home screen, 
    -isAuthenticated not propgating, 

252

For launch--
  Permissions / TOS
  add ios and android setup, 
  test -> production mode 
  add advertisements (capability) https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter#2

Add custom styling--
  -> make custom with of nectar style 


## Features
- Google/Guest Authentication
- Create, Join community
- Community Profile (Avatar, Banner, Members) 
- Edit Description and Avatar of community
- Post (link only, photo, text only) 
- Displaying posts from communities user is part of
- Upvote, Downvote
- Comment
- Award the Post
- Update Karma
- Add Moderators
- Moderator- remove post
- Delete post
- User Profile (Avatar, Banner) 
- Theme SwitchY

- Cross Platform
- Responsive UI
- Latest posts (instead of home, display this to guest users) 

## YouTube
I have created a tutorial based on this, do check it out on my channel [Rivaan Ranawat](https://youtu.be/B8Sx7wGiY-s) 

<p align="center">
  <img width="600" src="https://github.com/RivaanRanawat/flutter-reddit-clone/blob/master/screenshot.png" alt="Youtube Tutorial Image">
</p>


## Installation
After cloning this repository, migrate to ```flutter-reddit-clone``` folder. Then, follow the following steps:
- Create Firebase Project
- Enable Authentication (Google Sign In, Guest Sign In)
- Make Firestore Rules
- Create Android, iOS & Web Apps
- Use FlutterFire CLI to add the Firebase Project to this app.
Then run the following commands to run your app:
```bash
  flutter pub get
  open -a simulator (to get iOS Simulator)
  flutter run
  flutter run -d chrome --web-renderer html (to see the best output)
```

## Tech Used
**Server**: Firebase Auth, Firebase Storage, Firebase Firestore

**Client**: Flutter, Riverpod 2.0, Routemaster
    
## Feedback

If you have any feedback, please reach out to me at namanrivaan@gmail.com
