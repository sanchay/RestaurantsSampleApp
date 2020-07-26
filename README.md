# RestaurantsSampleApp - Restaurant Viewer using Yelp API
This app consumes APIs provided by Yelp and displays restaurant information.

## Target Devices

iPhone only

## App features
1. App uses onboarding to enable user to allow/disallow device location 
2. App may use device location to fetch restaurant data
3. App may use manually provided location info (city name, neighbourhood name) to fetch restaurant data
4. App displays a list of 20 restaurants (to display scrolling behavior across all devices) in a grid (collection) view
5. User can select a restaurant from the list and view its image, name, and address along with the last review posted 
6. User can add restaurants in a favorite list
7. User can view the favorite restaurants in the favorite list and can view additional details of the saved restaurant
 

## App Design Approach

### Architecture

MVP (Model View Presenter) is the underlying architecture for the app to function. 

Each view controller class is tied to a presenter which takes care of processing data fetched from the networking module 
The presenter also updates the view controllers using a completion mechanism for various functions
The view controller's responsibility is to primarily update UI state

### Networking

Networking uses a protocol based implementation of URLSession

### Models

For data not required to be persisted, models implementing Codable protocol are implemented. 

### Core Data Models

For data required to be persisted, NSManagedObject subclasses implement the Codable protocol

### UI Implementation

1. Single storyboard for all view controllers
2. OnboardingViewController, SearchTermViewController, and SearchResultViewController are defined in the storyboard
3. DetailViewController scene is defined programmatically

### Unit Testing

## Assumptions

1. User may or may not enable location usage in the app. If location is enabled, then the SearchTermViewController allows users to provide text input. Autocompletion APIs from Yelp are consumed to display a list of terms.  
2. If location is not enabled, the SearchTermViewController view displays input fields for search term and a location (city name, neighbourhood name).
3. App need not support landscape mode
4. Internet connectivity is required to run the app satisfactorily
5. Localization is not required

