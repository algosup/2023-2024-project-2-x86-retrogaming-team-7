# Test plan

This document is divided into 3 main parts, them being: The pre-developement phase, the development phase and finaly the post developement phase. Each follows the same structure of going from the most obvious possible technical issues to the less obvious.
The main goal of this test plan is to anticipate the technical issues that could occur when the final product will be presented to the client. 
These test are all seperated by categories and all the details of all the tests that have been done are specified in the details part. 
To allow the other members to see clearly the technical issues that was encountierd, Images (screen shots) are all shown in the Image section at the bottom of this document.

## Pre-development
In this phase, the main goal is to see if every aspect before development is correctly done, main requirements such as the technical specification or the functional specification have to be quality assured before sending these documents to the client. These "tests" are meant to prevet any mistakes that could have been slipped in for any reason.
>|Process|Description|Status|Expected result|Actual result|Comment|Time took|
>|:-|:-|:-|:-|:-|:-|:-|
>|**Functional specification**|Verify is all it's content is right and that there is no grammer or spelling mistakes|**<span style = color:green>Completed</span>**|All content is correct and that every functional specification is detailed and clear enough|Missed some points but kept the essential ideas and some minor english mistakes|In the overall the document was good however needed some clearity and needed to add some extra specifications to make it even more clear.|3 hours|
>|**Technical specification**| Verify that the document is a detailed blueprint of a product development project. It translates complex business requirements into an understandable plan of action for the team, bridging the gap between non-technical stakeholders and developers. |**<span style = color:green>Completed</span>**|Every aspect of the technical side is clear and that the document gives enough details without giving too much.|Some parts were too detailed and ambigeous to the reader. It was a little bit confusing to read it and understand the use of the detail for the final product.|Changes were done and the document is much more understandable then before and changed some syntaxical errors.| 4 hours|
>><details>
>>  <summary>Details technical specification</summary>
>>  
>>  |Part|Description|Test|Expected result|Actual result|Status|Comment|if issue status|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:-:|
>>  |**Introduction**|Verify if the Indrocution catchs the reader's attention, gives background on the subject and presents the central idea of the whole technical part of the product.|Verify the content is correct and meets expectations| Consise Introduction with the central idea clear and easy to understand. Verify if the Purpose and the scope of the product is clear.|The introduction was satisfactory|**<span style = color:green>Completed</span>**|Nothing much to add|N.A.
>> |**System Architecture**|Verify that it gives a conceptual vision on the struture of the system. It should implement a high-level Overview of the product, a block Diagram, and an Architecture Diagram.|Verify is every aspect of the system achitechture is clear, and that it contains all the essentials to understand. | Every mentionned aspect should be clear and written |Some aspects are ambigous|**<span style = color:green>Completed</span>**|Good|**<span style = color:green>Solved</span>**
>> |**Game components**|Components of the final product which males up the product define it's rules, challenges, and interactions. The goals of the final product should be clear, it should be the same for the rules, challenges.| Verify if every part of the game components and the objects of the final product is clear for the player and the client.| A layout of every mentioned aspect.|Very clear and met expectations|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Assembly language and NASM**| Assembly language and using NASM was part of the requirements, due to the requirements it has to be explicitly mentioned in the technical overview of the product.|Verify if it's content is understandable. |Explanation of why Assembly is th choosen language, and explanation on what is NASM and it's functionality.|Explainations were clear|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Development Environment**| DOSBox was one of the other requirements of this project, however it is important to show why this envroment and what's it's purpose to keep transperency between the client and the developing team.This part also talks about what were the different tools used to acheive the final goal.|It should explain clearly what is the role of an enviroment and what the DOSBox enviroment will allow the team the acheive, it should show the overview of the enviroment and mention explicitly on what version the final product will run on.|All informations on the development environment should be clear and in an vocabulary that is understandable to everybody.|Vocabulary issues, not quite understandable|**<span style = color:green>Completed</span>**|really clear|**<span style = color:green>Solved</span>**
>> |**Performance Considerations**|Explinaition on how the code will be optimised and basic explanation on how the final product will run.|The notion of sprites and how the collisions and all the different commands that will be used should be clear|All the technical aspect of the performance and how the team will acheive the goal to optimise the code should be understandable|Understandable but not quite what was expected|**<span style = color:green>Completed</span>**|Explain more on why the use of sprite were the right choice|**<span style = color:green>Solved</span>**
>> |**User interface design**|The user interface is one of the crucial elements for the product to be visualy pleasing and captivating.|Verify if the content cooresponds to the goals.|The content of this part should specify every aspect of the user's interface, every controls that the User will have over, the different keybnds, what will be included such as sounds or other specificaitons.|The user interfce design is clearly stated with what will be implemented in the main screen and on the game sreen|**<span style = color:green>Completed</span>**|Good nothing to add|N.A.
>> |**Game logic and mechanics**|To be able to move Pac-Man in the direction that the player wants or to automate the movements of the Ghosts in the maze there are games mechanics involved, in this part every mechanics of the game should be specified and clear.| This part should include the Movements of all the different charactors of the products and all it's algorithms keeping in mind the time, the evolution of the points, and game progression...|The logic of the game should be stated, the movements of Pac-man and how the ghosts will be comporting in the Maze.|Clear explanation on what are the mechanics of th ghosts|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Documentation**|Clear communcation between the client is crucial but also transperency on the technical part of the product is key. Which is why documentation allows clear communication between team members but also between the client and the team.| This part should include all the documentation on the code comments, the function level comments and the Algorithmic comments.|Documentation should be clear, and the purpose of each documentation should be clear|Very well explained|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Future enhancements**|After the launch of the product it is important to make sure that it will run as smoothly as the first date of launch, to allow that updates has to done and adaptations will have to be done. |In this part future enhancements on the product such as update compatibilty of the software is important, which will allow the client to feel confident on the durability of the product.|The future enhancements should explain the furture features that the team would like to add after that the basics of the final product is acheived|Role change in the game was clearly explained all the different future enchancements were clear.|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Function explanations**|For the client to know how the product works he will have to know the back end of every action that is possible on the game.|Every action is listed on this part and explaned how it works.|The Back end of the final product should be clear, how the team is going to answer the needs of the client should be explicitly said. |Every aspect is clear.|**<span style = color:green>Completed</span>**|Good|N.A.
>> |**Conclusion**|Conclusion will wrap up all the aspects of the technical specification|It will also allow the client to be satisfied about all the technical part of the final product.|Conculsion should conclude all topics covered in the document|Good sum up of the whole document|**<span style = color:green>Completed</span>**|Good|N.A.
>></details>
>|Process|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:-|:-|:-|:-|:-|:-|:-|
> |**Project charter**|The project charter should be a short document that explains the project in clear, concise wording for high-levelmanagement|**<span style = color:Orange>Work in progress</span>**|...|...|...|...|...|
> |**Weekly report**| Every week has to be reported of the progress of the team containing the acheivements and the overall progression of the work.|**<span style = color:Orange>Work in progress</span>**|The overall content should be honest and correct reporting the evolution of the team work of the week|**<span style = color:Orange>Work in progress</span>**|Some minor modifications on different weekly reports but in overall was good| 1 hour per week|
>><details>
>>  <summary>Weeks</summary>
>>
>>  |Week|Status|Comment|     
>>  |:-:|:-:|:-:|     
>>  |1|Complete|Some minor changes regarding the content|     
>>  |2|Complete|Very few changes| 
>>  |3|Complete|Some changes on the words used|
>>  |4|Complete|Some changes on the conclusion|    
>></details>

## Development
> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|Sprites |Verify that all sprite are corresponding and not pissing any pixels|**<span style = color:green>Completed</span>**|all sprites are corresponding to what was expected|Some colors conversion problems but resolved.|Some difficulties on finding the right color pallet for the right environement that we are working on| 3 hours|
>
>> <details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> |Sprite|1|Visual check of the Ghosts sprites making sure that they look the same as the one we decided to implement|Look side to side the prototyped sprites and the coded version of the sprite, verify if there is any eye catching difference. Copy code of each sprite and paste in VS code to open each sprite on DOSbox.|**<span style = color:green>Completed</span>**| No visual difference and that every color is alike.|Some color conversion problems but fixed|Had some hard time converting the colors from the platform "asprite" to HEX colors, however we filtered the colors on the platform and modified the colors to the desired one in HEX form.|N.A.
>> |Sprite|2|Visual check of the Pac-man sprites making sure that they look the same as the one we decided to implement|Look side to side the prototyped sprites and the coded version of the sprite, verify if there is any eye catching difference. Copy code of each sprite and paste in VS code to open each sprite on DOSbox.|**<span style = color:green>Completed</span>** | No visual difference and that every color is alike.|There was no visual difference and every color was alike.|Every sprite is corresponding to what was expected|N.A
>> Sprite|3|Visual check of all the fruits sprites, making sure that they look the same as the one we decided to implement|Look side to side the prototyped sprites and the coded version of the sprite, verify if there is any eye catching difference. Copy code of each sprite and paste in VS code to open each sprite on DOSbox.|**<span style = color:green>Completed</span>** |All the fruit sprites should look alike|Looks alike|No comments good|N.A.
>> Sprite|4|Visual check of all the pellets and the super pellets sprites, making sure that they look the same as the one we decided to implement|Look side to side the prototyped sprites and the coded version of the sprite, verify if there is any eye catching difference. Copy code of each sprite and paste in VS code to open each sprite on DOSbox.|**<span style = color:green>Completed</span>** |All the sprites should look alike|No visual difference| good|N.A.
>> Sprite|5|Visual check of all the Maze sprite, making sure that they look the same as the one we decided to implement|Look side to side the prototyped sprites and the coded version of the sprite, verify if there is any eye catching difference. Copy code of each sprite and paste in VS code to open each sprite on DOSbox.|**<span style = color:green>Completed</span>** |The Maze sprite should look alike|Maze sprite is correct|Correct however have to check how it looks like on DOSbox|N.A.
>> </details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Movements|The movement of all the different sprites on the screen is defined either by the player or a program that will indicate the movements of different sprite such as the ghosts.|**<span style = color:Orange>Work in progress</span>**|The movements of Pac-Man should be coordinated with the player's desires, the movements of the ghosts should be programmed both with no technical issues.|**<span style = color:Orange>Work in progress</span>**|Some improvements are being done.|1 hour
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> |Movements of Pac-Man|1|Pull code from Github desktop and try the movements of Pac-Man on the map verify if there is no bugs on the screen (teleportation, system failure, sprite going off limits...)|Push the limits of the sprite to the limits of the screen|**<span style = color:Green>Completed</span>**|Pac-Man stays within the limits of the screen, in both formats of screen (Full screen & smaller screen)|Pac man stays within the screen and doesn't have any issue of teleportation.|The sprite of Pac-man tends to flicker as it moves around the screen.|**<span style = color:green>Fixed</span>**|
>> |Movements of Pac-Man|2|Pull code from Github desktop and try the movements of Pac-Man on the map verify the controlability of the sprite. Use arrows on the keyboard to see if it's going the same direction as wanted|Chekc if the movements of Pac-man corresponds to the directions instructed by the keyboard arrows|**<span style = color:Green>Completed</span>**|Pac-Man moves in the direction wanted.| Pac man moves in the directed wanted on the screen with one press of the button(One click on the arrow key moves Pac-man to the end of the screen)| Direction works however when long pressed on one button Sprite disapears from screen!|**<span style = color:green>Fixed</span>**|
>></details>
> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
> Main menu|As the main menu is the first page that every user will land on, the tests are based on two  main ideas, functionality and visuals.|**<span style = color:Orange>Work in progress</span>**|The main menu should be fully functional with buttons that works and the user can navicate on the screen with the keys.|Everything is contralable however the visual doesn't meet the expectations|Still a lot of work has to be done|30 min
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Main menu|1|Pull the code from github and look if the main menu is functional and visualy pleasing|check if the main menu buttons are functional, leads to another page, and are controlable with the arrows of the keyboard|**<span style = color:Orange>Work in progress</span>**|The main menu should be contrable and functional. In a general point of view it is visualy pleasing.|The main menu is contrable it is possible to move around from one button to another with the arrows.|Non complete due to the the main menu being nothing but a screen with three buttons and not visualy pleasing. In addition the buttons aren't functional they do not lead to another page such as the game or the settings|**<span style = color:Orange>Work in progress</span>**
>></details>
> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
> Settings menu|Check if the settings are fully functional and does what it is supposed to do=change settings such as keybinds, volume etc.|**<span style = color:Orange>Work in progress</span>**|All the settings are corret, user can navigate and modify to their prefered settings|Not completed yet|Work in progress.|N.A.
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Settings menu|1|Check if the button actions does what it is supposed to do|click on and keybind modification and check if it modified the keybinds|**<span style = color:Orange>Work in progress</span>**|All the modification of keybinds corresponds to what the user wants|Not developed yet|Work in progress|N.A.
>></details>
> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Exit|a button should allow the user to exit the game, this button should be fully functional|**<span style = color:Orange>Work in progress</span>**|When the button is pressed it quits the game|...|...|N.A.
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Exit  menu|1|Click on exit button|Check if it does the command it is supposed to do|Quits the game|...|work in progress|N.A.
>></details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Scoring|Scoring will bedisplayed on the screen during the game and the number of points should correspond to the actual points|**<span style = color:Orange>Work in progress</span>**|Scoring evolves each pellet, Fruit, ghost, ingested by Pac-Man.|Work in progress|...|N.A.
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Score system|1|check the sprites display number|Check for pixel missing or any color problem|**<span style = color:Orange>Work in progress</span>**|No visible difference|...|...|N.A.
>></details>
> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Maze|Make sure that the Maze is correct without any design flow.|Maze is correct that all the pixels are where they are supposed to be and that the overall is visually pleasing|**<span style = color:Orange>Work in progress</span>**|...|...|N.A.
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Maze [^1] |1| First check on the visual of the Maze and verify if the design of the Maze is correct and that there is no flows in the design.|The Maze has to have no flows to allow Pac-Man and the ghosts to move inside of the intended spaces. Check that the Maze looks alike to the skateched design on Asprite.|**<span style = color:Red>Issue</span>**|Looks alike and visualy pleasing| some flows in the design with some borders being inverted.|Image shows the different design flows.|**<span style = color:Orange>Work in progress</span>**
>></details>

## Post Development (Final product)

The following tests will be made after that the final product is assembled togther, these tests will allow to decide if either the product is ready to be launched or not. These tests will make sure that there is no technical issues. These tests are based on what was promised in the functional specification and pushs the limits of the code before presenting the final product to the client.

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Game test**|General check of playability & if the game respects all the criterias|**<span style = color:Orange>Work in progress</span>**|The final expectation of the final product is that the game is fully functional and that the user experience is pleasent. The full experience of the game should flow without any technical issues|...|...|...|
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|--:|:--:|
>>  |Visual|1|Check the visual aspect of the final product, main menu, settings menu, game etc.|Navigate throught out the game and look out for design flaws.|**<span style = color:Orange>Work in progress</span>**|No visual problem with the sprites or any other visual aspect of the final product.|...|...|...|
>> Stress test (User experience)|1|The Tests consists of trying to overload the system with many information and look at the results|Selecting as many as functional button, continusly press on the select button...|**<span style = color:Orange>Work in progress</span>**|In the overall the User experience should be flawless and the user should not get bored or have to wait too long for a program to launch.|...|...|...
>> CPU and Processor stress test|2|The goal of this test is to test the limits of the CPU and it's processor|Figure a way to overload the system to result into a system failure.|**<span style = color:Orange>Work in progress</span>**|In the code there should be no cracks for any system ovrload to happen, at least it should be prevented and the user should not encounter any system failure|...|...|...
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Controlability**|Check if the buttons from the instructions work correctly, if all buttons corresponds to what it is supposingly controling|**<span style = color:Orange>Work in progress</span>**|All controlable aspects of the final product should be functional|...|...|...
>><details>
>>  <summary>Unit tasks of controlability</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |Pac-Man|1|Press left|When game launched press left arrow button|**<span style = color:Orange>Work in progress</span>**|Pac-man should turn left with sprite change with animation|...|...|...
>>  |Pac-Man|2|Press right|When game launched press right arrow button|**<span style = color:Orange>Work in progress</span>**|Pac-man should turn right with sprite change with animation|...|...|...
>>  |Pac-Man|3|Press up|When game launched press up arrow button|**<span style = color:Orange>Work in progress</span>**|Pac-man should turn upwards with sprite change with animation|...|...|...
>>  |Pac-Man|4|Press down|When game launched press down arrow button|**<span style = color:Orange>Work in progress</span>**|Pac-man should turn downwards with sprite change with animation|...|...|...
>> Pac-Man|5|Press at the same time left and right keys|During the game play, press the left and right arrow simultainusly.|**<span style = color:Orange>Work in progress</span>**|No difference, or only one direction will be selected.|...|...|...
>>
>> Navigation|1|Press down|in main menu and other menu press down button|**<span style = color:Orange>Work in progress</span>**|The possibility to select a button changes to the one under or scrolls to the top one|...|...|...
>> Navigation|2|Press up|in main menu and other menu press up button|**<span style = color:Orange>Work in progress</span>**|The possibility to select a button changes to the one on top or scrolls to the bottom one|...|...|...
>> Navigation|3|Press enter|in main menu and other screens (settings menu etc) menu press enter button|**<span style = color:Orange>Work in progress</span>**|Will allow the user to select the button that was selected|...|...|...
>> Navigation stressed|4|Press at the same time left and right|In main menu press the left and right arrow simultainusly.|**<span style = color:Orange>Work in progress</span>**|No difference, or only one direction will be selected.|...|...|...
>> Navigation stressed|5|Press at the same time up and down keys|In main menu and other screens (settings menu etc) press at the same time up and down button and observe the results.|**<span style = color:Orange>Work in progress</span>**|No difference, or only one direction will be selected.|...|...|...
>>Navigation Stressed|6|Press an arrow key followed rapidly with the enter button| In main menu and other screens (settings menu etc) press and arrow key followed rapidly with the enter key and obeserve the results.|**<span style = color:Orange>Work in progress</span>**|The program should be able to follow the desires of the user and should be able to follow the speed of decision of the User.|...|...|...
>> Navigation double press|7|Double press a key for instance arrows|In main menu double press the arrow keys and observe the results.|**<span style = color:Orange>Work in progress</span>**|There should be no particular errors in this test, the selction should be able to follow what the user wants to select.|...|...|...
>>  Navigation double press|8|Double press a key for instance enter|In main menu double pess the enter button and observe the results|**<span style = color:Orange>Work in progress</span>**|There should be no particular errors in this test the selected button should be applied without any technical dificulties. |...|...|...
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Loading**|Verify if the loading works|**<span style = color:Orange>Work in progress</span>**|Loading time not too long|...|...|...|
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |Loading animation|1|time the loading time to launch the game|Loading time not too long|**<span style = color:Orange>Work in progress</span>**|...|...|...|
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Effects**|Display of the pac man opening and closing||Animations of the ghost and pac man should be in the maze and not affecting the map except the points|||
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected|result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Visual**|Verify if the visual is generaly clear and pleasing||Animations of the ghost and pac man should be in the maze and not affecting the map except the points|||
>><details>
>>  <summary>Unit tasks of visual</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |Verify is the classic pac man is reconizable|Test number|Test|Description|Status|Expected result|Actual result|Comment|
>>  |Map should be in the limits of the scree|Test number|Test|Description|Status|Expected result|Actual result|Comment|
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Content**|Content of the original game meaning 4 ghosts, pac man, fruits, points super points|||
>><details>
>>  <summary>Unit tasks of visual</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |Level indicator is correct||||||||
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Features**|Verify is the classic pac man is reconizable||Animations of the ghost and pac man should be in the maze and not affecting the map except the points|||
>><details>
>>  <summary>Unit tasks of visual</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Buffers**|Verify is the classic pac man is reconizable||Animations of the ghost and pac man should be in the maze and not affecting the map except the points|||
>><details>
>>  <summary>Unit tasks of visual</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>
>></details>
>---


This allows the team to have a dfferent point of view of the product. 
With the detection of an issue the team will be able to fix the issue quickly before the official launch of the product. -->

## Images 
> Concerned part|Issue description |Status|Comments
> |:-:|:-:|:-:|:-:|
>  Maze|Circled areas aren't correct | **<span style = color:Orange>Work in progress</span>** | Map visuel aren't exactly what was expected.
> [^1]: ![image](https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-7/assets/147847949/227d5b50-5dfb-472e-abaa-9a60137da0e6) |

> Concerned part|Issue description |Status|Comments
> |:-:|:-:|:-:|:-:|
> 


