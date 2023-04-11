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

Removed studyTask, as ContentView will now be used DataModel values.
Added NavigationView, in order to navigate to each individual course and its respective tasks.
Refers to model in List{}, showing each course in testStudy.
Added courseName to data source
Created extension of Study struct, to create course, which includes courseCode and courseName.
In List{}, course is shown.

Added navigationTitle, as "My Courses"
Used navigationBarItems, to add the EditButton and "plus" Button.
Found when wanting to add a new course, that I could not only call courseName and courseCode, so made values such as task and checkbox optional in DataModel. 
Used .onDelete, allows any course in list to be removed.
Used .onMove, allows any course to be moved within the list.

Removed navigationTitle, as TitleView is being used.
Used NavigationLink, as each course has a separate page, with any of its associated tasks.
Created DetailView, which will show each courses associated tasks.
Grouped DetailView, under Views group, as is best practice.
Specified in DetailView that the DataModel (model) is binding, meaning that instead of creating new instance for all properties, it is connected to the original data course. DetailView is now connected to original data source and can modify said source.

Changing formatting and data displayed for ContentView, to be more useable.
Checked the formatting was viable for other screens and devices, as most testing has been done on the iPhone 11.

### 05/04/23
This is where I felt lost in the project. I decided to review Larry's code supplied to help students. Realised I need to create a parent list (which would be the courses) and then a child list (which would be its tasks, and whether it has been completed)
Created struct StudyTask, which will represent each courses individual tasks.
Inside testStudy, Study() has its own course (parent), then inside that course, is the list of StudyTask allocated to specific course (child)
This casued issues in my ContentView(), as I need to update it to suit new DataModel. Comments in ContentView describes changes required. I found my app to be buggy after these changes.

In DetailView, user can change the courseName instead of courseCode (e.g. Big Data Analytics to BDA), and can also change the courseCode.
In ContentView(), when user adds a new course, changed the default values to Code and Course Name.
In DetailView, formatted courseName and courseCode in HStack, used padding() and coloured gray, to indicate to users these can be changed.
Noticed that when using TitleView with NavigationView in ContentView and DetailView, the UI does not look great. This was frustrating as I searched online, StackOverFlow recommended to move the navigationBarItems outside of VStack, it already was. I then decided to create a toolbar instead of using the.navigationBarItems modifier. This did not work. Ultimately, I decided to alter the TitleView itself and this solved my UI problem.

DetailView needs to allow user to interact with tasks, edit/delete and reset the status of each task. I follow similar logic and structure used in ContentView. Comments in DetailView describe specific changes I made. I have found that when user clicks on tasks, to indicate whether it is completed or not, DetailView jumps back to ContentView. I keep jumping to ContentView probably because I am pushing DetailView onto the navigation stack using NavigationLink. I need to embed DetailView in a NavigationView, e.g. @ObservableState?

### 06/04/23
Disliked how while "University Courses" is supposed to be the title, that each course was larger in font and that the course list was unappealing looking in other iOS devices. Played around with .font() to get the desired appearance. Changed Hstack to Vstack.
Wanted to format DetailView further, to suit the new formatted ContentView. Used the font caption to minimise the textfields of course code and course name. Used subheadline for task description. 
While changing aesthetics, one requirement of M2 was to change the back button from its default arrow to the word "Back". Hid the default back button, then created a new "Back" button to take its place. This pops DetailView (child view) off the current stack, and returns to ContentView (parent view). 

### 07/04/23
When editing tasks in DetailView, another requirement of Milestone 2 is to allow new entries of tasks. I uncommented the code I created previously for adding new tasks, however, the user will not be able to change task description. Ensured user can change the task description but I put the button with the other buttons in the navigation tool bar, which makes the toolbar overcrowded. Moved Add button to under the default tasks, which is more user friendly.
Used trial and error to make the new task seamlessly integrate with the task list.

Deleted ListRowView, as it is no longer needed for Milestone 2.
In CheckList Tests, my first function, testCourseCode, checks whether each course has the correct course code as its value. My second function, testCourseName, checks whether each course has the correct course name, as its value. Both pass the test.
My third function, testTasksCount, checks whether each course has the correct amount of default tasks, which should be 2. The test passed.
My fourth function, testToggle, checks whether the toggle functionality works. I first checked that the first course and its first task worked, the test passed. I then continued to test the first course and its second task, the test passed. This should be applicable for all courses and their tasks.

Went through code to properly comment any functions, methods and structs.

Built documentation (DocC) for application.
Added video for Milestone 2.
Tagged commit as "milestone2" and tagged "milestone 1".

### approved extension for the 7th of April, 11:59pm, thank you!
##Second Milestone Video: https://youtu.be/rqf8ZxKWsA4

### 11/04/23
Added icon for checklist application. 
