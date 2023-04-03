# Checklist by Brianne Byer
## First Milestone

The purpose of this Readme is to demonstrate how I have completed the assignment.
I will explain my steps, how it was implemented and what I learned.

### 15/3/23
Created the Readme by clicking File/New/File and choosing Empty for Documentation Template.
Created a list, called studyTasks, with 4 values (goals).
Used VStack, which formats objects vertically, to show each goal in studyTasks

Added the associated course to each goal into studyTasks list
Used HStack, which formats objects horizontally, to show each goal with its respective course.
Added Image to HStack, added tick boxes to certain goals, but since I didn't have index[2] for certain goals, a Fatal error occured. Meaning I require an image/index[2] for each goal.
Added filled and unfilled checkboxes to show which were completed. Solved fatal error.

Converted HStack, into ExtractedView and renamed ListRowView.
In ListRowView, studyTask is referred to as item, course being item[0] and so on.
Formatted ListRowView, like making course text bold, using Spacer() to align the tick boxes to the right of the screen

Checked that formatting suited other iPhones, iPads and IPods. Goals are multiple lines of text. Tried to use linelimit(1), which cut off goal text for certain screens. Removed padding for course text, then used fixedSize() for course and goal text. Checked different screens again, looks good!

Created View group, to add all SwiftUI views, as is best practice. 
Created separate view for ListRowView and moved appropriate code from ContentView, into ListRowView.

Wanted to create a Title for the Content View. 

###23/3/23
Created Documentation, which will be used in M2
Created DataModel, grouped under Models, to use for testing later
Created TitleView, placed under group Views
Played around with formatting book image and title
Called TitleView in ContentView, so it is viewable. Removed previous Text("University Courses").

###26/3/23
Went into DataModel, started to create a struct for Study. Learnt that UUID() creates a universally unique variable. Initially had issues created the struct Study, as I had used "=" for each member, which caused an error. Realised "=" declares a mutable value and assigns an instance, whereas, ":" declares a mutable value and assigns the type of the variable.

General formatting/cleaning of code to make it easier to understand

Had confusion with pushing and pulling to GitHub, so fixed those issues.
Had issues making tests work, even though they should pass. Found out I accidentally made breakdpoints and deleted them. It now works!
Tested that each task had correct course code.

Tested that each task had correct description.
Completed Milestone 1, tagged commit for reference.

##First Milestone Video: https://youtu.be/LouxmF9kHLI


## Second Milestone
### 04/04/23
Created a struct for DataModel, which uses values from testStudy.
In Checklist App, added DataModel so that it can be referred to throughout application.
Specified in ContentView that the DataModel (model) is binding, meaning that instead of creating new instance for all properties, it is connected to the original data course. ContentView is now connected to original data source and can modify said source.


##Second Milestone Video: https://youtu.be/LouxmF9kHLI
