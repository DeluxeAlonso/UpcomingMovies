# Upcoming Movies App

[![License](https://img.shields.io/badge/license-MIT-blue)]()
[![Platform](https://img.shields.io/badge/platform-iOS-violet)]()
[![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![codecov](https://codecov.io/gh/DeluxeAlonso/UpcomingMovies/graph/badge.svg?token=WlD3VVKP1p)](https://codecov.io/gh/DeluxeAlonso/UpcomingMovies)

Movies app written in Swift 5 using the TMDb API and demonstrating Clean Architecture, Dependency Injection, MVVM and Coordinators.

## Demo

<img src="Demo.gif" width="200" height="433" />

## Screenshots

<img src="Screenshots/Home.png" width=200 height=433> <img src="Screenshots/Detail.png" width=200 height=433>
<img src="Screenshots/Search.png" width=200 height=433> <img src="Screenshots/SearchResult.png" width=200 height=433>
<img src="Screenshots/Reviews.png" width=200 height=433> <img src="Screenshots/Videos.png" width=200 height=433>
<img src="Screenshots/Credits.png" width=200 height=433> <img src="Screenshots/Favorites.png" width=200 height=433>
<img src="Screenshots/SignIn.png" width=200 height=433> <img src="Screenshots/Profile.png" width=200 height=433>
<img src="Screenshots/CustomLists.png" width=200 height=433> <img src="Screenshots/CustomListDetail.png" width=200 height=433>
<img src="Screenshots/TodayExtension.png" width=200 height=433> <img src="Screenshots/Widgets/Small/Upcoming.png" width=200 height=433> 
<img src="Screenshots/Widgets/Small/Search.png" width=200 height=433>

## How to run

### Requirements

1. Xcode 14.0+
2. Cocoapods 1.9.0+
3. Fastlane 2.1.0+ (only needed if you want to run the unit tests and swift lint scans via the CLI).

### Getting started

1. Clone this repository.
2. Via the CLI, go to the root folder of the project where Podfile is located and run `pod install`.
3. Open the workspace file and you are ready to go.

*Note: you can run the tests either using `CMD+U` on Xcode or running `fastlane tests` via the CLI.* 

## First-party libraries

### DLProgressHUD (https://github.com/DeluxeAlonso/DLProgressHUD)
Lightweight Progress HUD implementation for iOS.

## Third-party libraries

### Kingfisher (https://github.com/onevcat/Kingfisher)
Used for downloading and caching images. In the app, it is used to show the poster and backdrop image of the movie.

### CollectionViewSlantedLayout (https://github.com/yacir/CollectionViewSlantedLayout)
Custom UICollectionViewLayout to display slanted content. In the app, it is used to present the list of favorite movies.

### KeychainSwift (https://github.com/evgenyneu/keychain-swift)
Helper functions for saving text in Keychain securely for iOS, OS X, tvOS and watchOS. In the app, it is used to save the Session Id and Account Id of the signed in user.

### SwiftLint (https://github.com/realm/SwiftLint)
A tool to enforce Swift style and conventions.

### Swinject (https://github.com/Swinject/Swinject)
Dependency injection framework for Swift.

## Contributing

Feel free to open an issue or submit a pull request if you have any improvement or feedback.

## Author

Alonso Alvarez, alonso.alvarez.dev@gmail.com
