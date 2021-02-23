# NameGame-UIKit

## About the Project

This project was created as an interview project for [WillowTree](https://willowtreeapps.com/). I built this final version using UIKit, but I did some exploratory work on a [SwiftUI version](https://github.com/RobSilverman/NameGame-SwiftUI) as well! Unit tests for the main `Game` class are included.

## Usage

This project was built in UIKit with no added packages. The designs require a SFSymbols 2 image, so the build is targeting iOS 14.

You can customize the length of Timed Mode games by changing the `gameLength` property in `TimedModeGame.swift`.

## Roadmap

If I had more time to focus on this project, some of the first things I'd continue to improve would be:
* Auto-layout improvements- portrait views are working well, as are landscapes with a distinct size classes, but I've had a bit of a hard time so far adapting to landscape on iPad displays. If you would like to see my attempt at programmatically building a constraint architecture around `UIDevice.current.orientation` and `viewWillTransition`, you can checkout the `savedHomeLayoutCode` branch!
* CollectionView Flow Layout- The game butons are resizing well overall, but struggle to adapt to view transitions.
* Refactor view controllers- I architected the view controllers to be functionally identical so that with a little more learning, they could be a single view controller with replacable Game controllers.
* TimerView as! BarButtonItem- I tried to add the custom TimerView as the rightBarButtonItem in Timed Mode, but doing so crashed the app. If I had more time, I'd look into the issue (something to do with key value-coding compliance) and move the timer from the main layout to the nav bar.
* UI Tests- a good UI test for this app would require significant mocked data, so I chose to instead spend my limited time on the unit tests.

## Contact

Rob Silverman - robert.silverman@hey.com

## Acknowledgements

Thank you so much to Tucker, Joe, Charlie, and Jill for all your help and mentorship in getting me to this point in learning iOS development. 
