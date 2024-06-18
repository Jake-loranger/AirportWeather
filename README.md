# AirportWeather
An iOS application that displays weather data for user-specified airports

## Mockup

## Design Decisions
- Responsive to multiple devices (iPhone, iPad) and landscape orientation
- Compatible with Light and Dark mode

## Time Sheet
### June 17th 
  - 2 hours - UI Planning in Figma, Data Investigation, Project/ReadME Setup
  - 2 hours - UITabBar, SearchVC
  - 2 hours - NetworkManager, WeatherReport Data Model, SegmentControlBar
### June 18th 
  - 1 hour - UI Planning for Condition/Forecast views, Aviation weather research
  - 1.5 hours - ConditionsVC layout
  - 3 hours - PersistanceManager, RecentsVC

## Issues Encountered
1. Dynamic UI element layout based on screen size
2. Figuring out what values in the JSON response are optional, looked for docs on the api but couldn't find any
     - When I called "kpm" at one point, it did not return a condition or forecast key-value pair, only windsAloft. I chose to make the forecast and conditions optional in the data model becasue of this
3. TableView's borders wouldn't reach the leadingAnchor of the view
4. Checking whether a recent was already within the userDefaults and if so moving it to the beginning of the array. Right now airports can be saved multiple times to the userDefaults

## Known Issues
1. UI Layout in landscape mode needs reconfiguration
2. Can add the same airport twice if you exclude the K or do lowercase vs. uppercase

## References/Libraries
### Pervious Code Bases
1. GithubFollowers
2. PricePulse
3. FlyFit
### Sean Allen on Youtube
