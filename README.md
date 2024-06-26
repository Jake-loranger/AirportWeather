# AirportWeather
An iOS application that displays weather data for user-specified airports

## User Interface
<img width="860" alt="AirportWeatherDesign" src="https://github.com/Jake-loranger/AirportWeather/assets/106925875/09b0a8f2-672e-4693-b74c-1156aedbe5c3">

## Design Overview
#### 3 Major Views
- Search
  - Enables the user to enter an airport symbol and navigate to the details view to see data for that specific airport
  - TextField checks and handles error for an empty entry
  - Airport symbol within the TextField is passed to the details view to make the network call
- Details
  - Makes a network call to the API using the airportSymbol.
  - If the airport data request is invalid, it pops the details view and presents the error on the search view.
  - If the airport data request is successful, it adds that symbol to UserDefaults and passes the data to the childVCs (Condition & Forecast) to display.
  - A segmentControlBar allows the user to switch between the Conditions view and Forecast view.
- Recents
  - Displays the UserDefault airports in a TableView in the order of last viewed
  - TableView is initially populated with the KAUS and KPWM airports by initializing the UserDefaults with those values in the AppDelegate.
  - User can swipe up to refresh the data displayed in the cell 
  - User can select a cell to view the details for that specific airport 
  - User can swipe left to delete that cell from the recents.
  
#### Data Display
- Condition
  - From my research, I learned that the METAR values are used to convey the current weather conditions so I chose to display that text value at the top. I also found that wind, visibilty, and sky coverage were important factors pilots consider for departure/arrival so I chose to include those at the top as well as weather conditions. As for the other values displayed, I kind of used my best judgement on what might be good to display. If I were looking to build this app further, I would do more user research and talk to pilots to see what they consider the most important factors.
      
- Forecast
  - The forecast view displays a table with a cell for each forecast given within the received forecast data. The title of each cell is the time period that the forecast is given for. The TAF, which I learned is similar to the METAR but for future conditions, is displayed for each time period along with the flight rules. I thought the flight rules would be good to display quickly to a pilot becuase it gives them a brief understanding of what the conditions might be like (IFR = bad conditions, VFR = good conditions). However, similar to the conditions view, I would want to talk to pilots to determine the best/most beneficial information to display here.


## Problems Overcome
#### JSON Data Optionals
I had trouble determining what key-value pairs in the JSON response were optional. At one point I input "KPM" as the aiportSymbol in Postman and it did not return a "condition" or "forecast" key-value pair, only "windsAloft". I looked for documentation on the API but was unable to find anything. For this reason, I chose to make the data types optional and deal with the nil case at the call site.

#### UserDefaults Filtering
When I initially integrated the saving of recent airports to UserDefaults, I encountered an issue where the same airport could be saved multiple times. I implemented logic to check whether the airport was already stored in UserDefaults, but it didn’t work as expected. After research, I believe this was because the logic was comparing the instances of the objects (reference counts) rather than the actual value of the airportSymbol within the objects. To fix this, I had the RecentAirport data type conform to Hashable in order to compare the values within the object.

#### View Stacking
When I initially set the actions for the SegmentControlBar states, I realized there were lots of Views stacked on top of each other in the view hierarchy. To prevent memory congestion, I created a function that removed a specified ViewController and implemented it into the SegmentControlBar action.

## Known Issues
- UI layout needs to be refactored to improve dynamic responsiveness for landscape mode and cross-platform compatibility (iPad, iPhone Max)
- PersistanceManager can add the same airport to UserDefaults if you exclude the K (KSEA, SEA)
- TableCell's border doesn't reach the leadingAnchor of the view
- TabBar hides the bottom of the TableView on ForecastVC

## Future Improvements
- Create a ViewModel for the AWConditionsVC to format the data, and deal with the optional values differently
  - Improves legibility, testability, and scalability
- Combine Search and Recents views
- Create skeleton cells for loading state
- Display full airport name in title
- Map of airport as an option on the SegmentControlBar using the longitude/latitude

## Time Sheet
#### June 17th 
  - 2 hours - UI Planning in Figma, Data Investigation, Project/ReadME Setup
  - 2 hours - UITabBar, SearchVC
  - 2 hours - NetworkManager, WeatherReport Data Model, SegmentControlBar
#### June 18th 
  - 1 hour - UI Planning for Condition/Forecast views, Aviation weather research
  - 2 hours - ConditionsVC layout, Data Formatting for display
  - 3 hours - PersistanceManager, RecentsVC
#### June 19th
  - 1 hour - Data Formatting for Conditions View
  - 2 hours - ForecastVC & ForecastCell
  - 2 hours - RecentsVC, RecentsCell, & Cleanup
#### June 20th 
  - 1 hour - ReadME documentation
   
## References
#### Aviation Weather Resources
  - [METAR data display](https://aviationweather.gov/data/metar)
  - [METAR explanation](https://learntoflyblog.com/metar-deciphered/)
  - [TAF vs. METAR](https://www.dtn.com/what-is-the-difference-between-metar-and-taf-in-aviation-aviationsentry-airline-edition/#:~:text=To%20put%20it%20simply%2C%20a,conditions%20for%20a%20certain%20period.)
  - [Pilot weather considerations](https://simpleflying.com/pilots-weather-knowledge-guide/)

#### Pervious Code Bases
  - [GithubFollowers](https://github.com/Jake-loranger/GithubFollowers)
  - [PricePulse](https://github.com/Jake-loranger/PricePulse)
  - [FlyFit](https://github.com/22annajohnson/FlyFit)
    
#### Sean Allen on Youtube
  - [iOS Interview Prep](https://www.youtube.com/watch?v=JzngncpZLuw)
  - [iOS Must Know Topics](https://www.youtube.com/watch?v=XTAziR-tY-A)

#### UIKit Docs
  - [UIStackView](https://developer.apple.com/documentation/uikit/uistackview)
  - [UISegmentControl](https://developer.apple.com/documentation/uikit/uisegmentedcontrol)
