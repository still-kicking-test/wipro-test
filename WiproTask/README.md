Running the app
---------------
The app has been built to show the forecast for London, UK.

The app may be built and run in the standard way from an XCode Simulator, though note that an appropriate 'development team' will
first need to be selected (in the 'General' tab for the WiproTask target).

It is suggested the iPhone 7 Plus Simulator is selected.

I have not created any Unit Tests (see below, 'areas for potential improvement').


Known deficiencies, considered non-critical for this task
---------------------------------------------------------

Error reporting is absent, apart from simple printing of messages to stdout.

No indication of 'busy' during network (api) call.

Not implemented any Reachability checks for the state of the internet connection.


Areas for potential improvement
-------------------------------

I have concentrated my efforts on the project architecture, ensuring that it is clean and de-coupled (rather than spending more time on the UI).

Unit Testing - obviously of paramount importance in a production system.

I could include further details to the forecast: cloud cover, humidity, day/night indication, etc. More icons could be included to display e.g. wind direction.

