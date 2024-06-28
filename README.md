# SafyPower App

## Project Overview
I developed the SafyPower mobile application using Flutter. This app includes several key functionalities such as user authentication, a home screen, a map displaying station locations, and various informational pages. Below, I explain the steps I took to build this project.

## Features Implemented
1. User Authentication:
- Sign-up page with phone number verification.
- Login page for existing users.
- Integration with Google, Apple, and email for account creation.

2. Home Page:
- Display the logo and app name.
- Buttons for scanning QR codes and viewing information on how the app works.
- Navigation to the map and menu pages.

3. Map Page:
- Display a Google map with station locations.
- Ability to toggle between map view and a list of nearby stations.
- Distance to nearby stations is displayed when in list view.
- Navigation buttons at the bottom for easy access to home, map, and menu pages.

4. Profile Page:
- Display user information such as name, email, and phone number.
- Allow users to edit their profile information.
- Proper validation for phone number length and required fields.

5. History Page:
- Display user's history of station visits.
- Organized by date with detailed information on each visit.

6. FAQ Page:
- Common questions and answers about the app.
- Option to contact support for further questions.

7. Contact Page:
- Display contact information for user support.
- Easy access to phone and email support.

## Detailed Steps

1. Setting Up the Project:
- Initialized Flutter Project: I created a new Flutter project using VS Code.
- Set Up Git: I initialized a Git repository and connected it to a GitHub repository.
- Install Dependencies: I added necessary dependencies such as get, google_maps_flutter, and universal_io.

2. Building the Sign-Up and Login Pages:
- Design UI: I created the UI for the sign-up and login pages based on provided mockups.
- Phone Number Verification: I implemented phone number input and verification code functionality.
- Third-Party Sign-In: I integrated Google, Apple, and email sign-in options.

3. Creating the Home Page:
- Logo and App Name: I displayed the SafyPower logo and app name with proper styling.
- Buttons for QR Code and Info: I added buttons for QR code scanning and viewing how the app works.
- Navigation: I set up navigation to the map and menu pages.

4. Implementing the Map Page:
- Google Maps Integration: I integrated Google Maps using the google_maps_flutter plugin.
- Markers for Stations: I added markers to indicate station locations on the map.
- List View Toggle: I implemented a button to toggle between the map view and a list view of nearby stations.
- Distance Display: I showed the distance to stations when in list view.

5. Profile and History Pages:
- Profile Information: I displayed user profile information and allowed editing.
- Validation: I ensured proper validation for phone numbers and required fields.
- History Display: I showed the user's history of station visits, organized by date.

6. FAQ and Contact Pages:
- FAQ Page: I listed common questions and answers about the app.
- Contact Information: I provided contact details for user support, including phone and email.

7. Navigation and UI Consistency:
- Bottom Navigation Buttons: I ensured consistent navigation buttons across all pages for easy access.
- UI Styling: I applied consistent styling, colors, and fonts across the app based on the provided mockups.

## Conclusion

This document provides a comprehensive overview of how I developed the SafyPower app, including user authentication, navigation, and various feature implementations. The project was built using Flutter and integrated with Google Maps for location-based services.