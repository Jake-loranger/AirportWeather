# AirportWeather
An iOS application that displays weather data for user-specified airports

## Mockup


## Design Decisions
- MVC architecture due to project size & complexity
- 3 Major Views (Search, Details, Recents)
  - **Search View**: Enables the user to enter an airport symbol and navigate to the details view for that specific airport. TextField checks and handles error for an empty entry. Airport symbol present within the TextField is passed to the details view.
  - **Details View**: Makes a network call to the API using the airportSymbol. If the airport data request is invalid, it pops the details view and presents the error on the search view. If the airport data request is successful, it adds that symbol to UserDefaults and passes the data to the childVCs (Condition & Forecast) to display. A segmentControlBar allows the user to switch between the Conditions view and Forecast view.
  - **Recents View**: Displays the UserDefault airports in a TableView. The user can select a cell to view the details view for that specific airport and swipe to delete that cell from the recents. The TableView is initially populated with the KAUS and KPWM airports by initializing the UserDefaults with those values in the AppDelegate.
- Compatible with Light and Dark mode

## Problems Overcome
1. Figuring out what values in the JSON response were optional. Looked for docs on the api but couldn't find any.
     - When I input "kpm" as the aiportSymbol in Postman, it did not return a "condition" or "forecast" key-value pair, only "windsAloft". For this reason, I chose to make the Condition and Forecast Types optional and to deal with nil case at the call site.
2. Checking whether a RecentAirport was already within the UserDefaults and if so moving it to the beginning of the array. Airports were being saved multiple times to the userDefaults. I fixed this by making RecentAirport Type inherit the Hashable class to be able to compare the values rather than the reference count of the object and by revering the list of RecentAirports before populating the TableView.
3. Dealing with optional values within the DataModel when populating the condition view.

## Known Issues
1. UI Layout needs to be refactored to enable dynamic response to landscape mode and cross-platform compatibility (iPad, iPhone Max)
2. Can add the same airport to recents twice if you exclude the K (KSEA, SEA)
3. TableView's borders wouldn't reach the leadingAnchor of the view

## Time Sheet
- June 17th 
  - 2 hours - UI Planning in Figma, Data Investigation, Project/ReadME Setup
  - 2 hours - UITabBar, SearchVC
  - 2 hours - NetworkManager, WeatherReport Data Model, SegmentControlBar
- June 18th 
  - 1 hour - UI Planning for Condition/Forecast views, Aviation weather research
  - 2 hours - ConditionsVC layout, Data Formatting for display
  - 3 hours - PersistanceManager, RecentsVC
   
## References
### Aviation Weather Resources
  - [METAR data display](https://aviationweather.gov/data/metar)
  - [METAR explanation](https://learntoflyblog.com/metar-deciphered/)
  - [METAR Decoder](https://www.weather.gov/media/wrh/mesowest/metar_decode_key.pdf)

### UIKit Docs
  - [UIStackView](https://developer.apple.com/documentation/uikit/uistackview)
  - [UISegmentControl](https://developer.apple.com/documentation/uikit/uisegmentedcontrol)

### Pervious Code Bases
  - [GithubFollowers](https://github.com/Jake-loranger/GithubFollowers)
  - [PricePulse](https://github.com/Jake-loranger/PricePulse)
  - [FlyFit](https://github.com/22annajohnson/FlyFit)
    
### Sean Allen on Youtube
  - [iOS Interview Prep](https://www.youtube.com/watch?v=JzngncpZLuw)
  - [iOS Must Know Topics](https://www.youtube.com/watch?v=XTAziR-tY-A)
