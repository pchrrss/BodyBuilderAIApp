# Body Builder AI App

Welcome to the **Body Builder AI** app! This is a fitness application that generates personalized workout plans based on user inputs, tracks progress, and allows users to manage and view their favorite exercises. It leverages Firebase for user authentication and cloud storage.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [API](#api)
- [Screens](#screens)

## Features
- **AI-Generated Fitness Plans**: Personalized workout routines generated using AI model.
- **Exercise Tracking**: Mark exercises as completed and track workout history.
- **Exercise Replacement**: Replace exercises in your workout using AI suggestions.
- **User Authentication**: Secure login with Firebase authentication.
- **Favorites**: Save favorite exercises for easy access.
- **Progress Tracker**: Track your weekly and daily progress.
- **Achievements**: View your fitness achievements.

## Getting Started

### Prerequisites
- Flutter installed on your machine.
- A Firebase project with authentication enabled.
- Internet connection to interact with the AI services and Firebase.

### Installation
1. **Clone the Repository**
    ```bash
    git clone https://github.com/yourusername/body-builder-ai-app.git
    cd body-builder-ai-app
    ```

2. **Install Dependencies**
    ```bash
    flutter pub get
    ```

3. **Set up Firebase**
   - Create a Firebase project in your Firebase console.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS).
   - Place them in the respective `android/app` and `ios/Runner` directories.

4. **Configure Environment Variables**
   - Create a `.env` file in the root directory and add the necessary environment variables (e.g., `GOOGLE_CLIENT_ID`).
   - Example:
     ```
     GOOGLE_CLIENT_ID=your-google-client-id
     API_URL=http://localhost:11434/api/generate
     ```

5. **Run the App**
    ```bash
    flutter run
    ```

## Project Structure
    lib/
    │
    ├── common/                      # Common utilities and extensions
    ├── common_widget/               # Reusable UI components
    ├── model/                       # Data models (e.g., Exercise, UserInputModel)
    ├── service/                     # Services (e.g., Firebase, API calls)
    ├── view/                        # UI screens
    │   ├── home/                    # Main views like Fitness Plan, Favorite
    │   ├── login/                   # Authentication views
    │   └── user_input/              # User input screens for fitness plans
    └── main.dart                    # App entry point

## Dependencies
- **Flutter**: ^3.x.x
- **Firebase Core**: ^3.x.x
- **Firebase Authentication**: ^4.x.x
- **Firebase Firestore**: ^4.x.x
- **Http**: ^1.x.x
- **Provider**: ^6.x.x
- **Flutter Dotenv**: ^5.x.x
- **Google OAuth**: ^6.x.x

You can view the complete list of dependencies in the `pubspec.yaml` file.

## Usage

### User Authentication
Users can sign in using Google or email/password authentication, and their fitness data will be stored in Firestore.

### Fitness Plan Generation
After signing in, users fill out a detailed form with personal fitness information (e.g., age, body type, goals), and the app will generate a workout plan using AI.

### Exercise Management
In each workout day, users can:
- **Complete** exercises, which updates the progress.
- **Replace** exercises with AI suggestions.
- **Like** exercises and save them to a "Favorites" list for later access.

### Progress Tracking
Users can track their weekly progress based on completed exercises and navigate through their workout history.

### Favorites
Liked exercises are saved to a collection attached to the user, allowing easy access in the “Favorites” tab.

## API
The app communicates with an AI-powered backend to generate fitness plans based on user inputs.

### API Example Request
```json
{
  "model": "body-builder-model",
  "prompt": "User inputs for fitness plan generation",
  "stream": false
}
```

### API Example Response
```json
{
  "age_range": "30-40",
  "body_type": "Athletic",
  "goal": "Gain Muscle",
  "workout_plan": [
    {
      "day": "Monday",
      "focus_area": "Strength",
      "exercises": [
        {
          "name": "Squats",
          "sets": 4,
          "reps": 12
        },
        {
          "name": "Push-ups",
          "sets": 3,
          "reps": 15
        }
      ]
    },
    {
      "day": "Tuesday",
      "focus_area": "Cardio",
      "exercises": [
        {
          "name": "Running",
          "sets": 1,
          "reps": "30 minutes"
        }
      ]
    }
  ]
}
```

## Screens

### 1. **Login Screen**
   - Users can sign in with Google or email/password credentials via Firebase Authentication.
   - Provides options for creating a new account or signing in with existing credentials.

### 2. **Home Screen**
   - Displays an overview of the user's fitness plan.
   - Users can navigate to different sections like "Fitness Plan", "Favorites", and "Activity".
   - Users can start or view the fitness plan generated based on their input.

### 3. **Fitness Plan Result Screen**
   - Shows the daily workout plan generated by the AI.
   - Users can mark each exercise as completed, and the app will track progress.
   - Includes an option to replace exercises with AI suggestions.
   - Each exercise has detailed instructions and can be expanded for more information.

### 4. **Favorites Screen**
   - Displays a list of exercises the user has marked as favorite.
   - Users can expand an exercise to view instructions or unmark them as favorite.
   - The list is synced with the user's cloud account to allow viewing across devices.

### 5. **Activity Screen**
   - Contains two tabs:
     - **History**: Shows a log of completed workouts and exercises.
     - **Achievements**: Displays badges or milestones achieved by the user during their fitness journey.
   - Users can track their weekly progress and view any completed exercises.

### 6. **Profile Screen**
   - Displays user details such as fitness goals and workout preferences.
   - Users can update their inputs (e.g., fitness goal, body type) at any time.
   - The profile screen also includes the option to log out from their account.

### 7. **Settings**
   - Allows users to manage preferences like notifications, display units, and privacy settings.
   - The settings screen is accessible from the profile or home screen.
