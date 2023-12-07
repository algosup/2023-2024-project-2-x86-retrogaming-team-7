# Test plan

This test plan will allow to clearly follow up and understand the different issues, this chart includs all the important aspects to fix and follow all the mind path of the quality insurer.

## Pre-development

>|Process|Description|Status|Expected result|Actual result|Comment|Time took|
>|:-|:-|:-|:-|:-|:-|:-|
>|**Functional specification**|Verify is all it's content is right and that there is no grammer or spelling mistakes|**<span style = color:green>Completed</span>**|All content is correct and that every functional specification is detailed and clear enough|Missed some points but kept the essential ideas and some minor english mistakes|In the overall the document was good however needed some clearity and needed to add some extra specifications to make it even more clear.|3 hours|
>|**Technical specification**| Verify that the document is a detailed blueprint of a product development project. It translates complex business requirements into an understandable plan of action for the team, bridging the gap between non-technical stakeholders and developers. |**<span style = color:green>Completed</span>**|Every aspect of the technical side is clear and that the document gives enough details without giving too much.|Some parts were too detailed and ambigeous to the reader. It was a little bit confusing to read it and understand the use of the detail for the final product.|Changes were done and the document is much more understandable then before and changed some syntaxical errors.| 4 hours|
>><details>
>>  <summary>Details technical specification</summary>
>>  
>>  |Part|Description|Test|Expected result|Actual result|Status|Comment|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |**Introduction**|Verify if the Indrocution catchs the reader's attention, gives background on the subject and presents the central idea of the whole technical part of the product.|Verify the content is correct and meets expectations| Consise Introduction with the central idea clear and easy to understand. Verify if the Purpose and the scope of the product is clear.|...|W.I.P.|Good|
>> |**System Architecture**|Verify that it gives a conceptual vision on the struture of the system. It should implement a high-level Overview of the product, a block Diagram, and an Architecture Diagram.|Verify is every aspect of the system achitechture is clear, and that it contains all the essentials to understand. | Every mentionned aspect should be clear and written |...|W.I.P.|Good|
>> |**Game components**|Components of the final product which males up the product define it's rules, challenges, and interactions. The goals of the final product should be clear, it should be the same for the rules, challenges.| Verify if every part of the game components and the objects of the final product is clear for the player and the client.| A layout of every mentioned aspect.|...|W.I.P.|Good|
>> |**Assembly language and NASM**| Assembly language and using NASM was part of the requirements, due to the requirements it has to be explicitly mentioned in the technical overview of the product.|Verify if it's content is understandable. |Explanation of why Assembly is th choosen language, and explanation on what is NASM and it's functionality.|...|W.I.P.|Good|
>> |**Development Environment**| DOSBox was one of the other requirements of this project, however it is important to show why this envroment and what's it's purpose to keep transperency between the client and the developing team.This part also talks about what were the different tools used to acheive the final goal.|It should explain clearly what is the role of an enviroment and what the DOSBox enviroment will allow the team the acheive, it should show the overview of the enviroment and mention explicitly on what version the final product will run on.|...|...|W.I.P.|Good|
>> |**Performance Considerations**|???|???|???|...|W.I.P.|...|
>> |**User interface design**|The user interface is one of the crucial elements for the product to be visualy pleasing and captivating.|Verify if the content cooresponds to the goals.|The content of this part should specify every aspect of the user's interface, every controls that the User will have over, the different keybnds, what will be included such as sounds or other specificaitons.|...|W.I.P.|Good|
>> |**Game logic and mechanics**|To be able to move Pac-Man in the direction that the player wants or to automate the movements of the Ghosts in the maze there are games mechanics involved, in this part every mechanics of the game should be specified and clear.| This part should include the Movements of all the different charactors of the products and all it's algorithms keeping in mind the time, the evolution of the points, and game progression...|...|...|W.I.P.|Good|
>> |**Documentation**|Clear communcation between the client is crucial but also transperency on the technical part of the product is key. Which is why documentation allows clear communication between team members but also between the client and the team.| This part should include all the documentation on the code comments, the function level comments and the Algorithmic comments.|...|...|W.I.P.|Good|
>> |**Future enhancements**|After the launch of the product it is important to make sure that it will run as smoothly as the first date of launch, to allow that updates has to done and adaptations will have to be done. |In this part future enhancements on the product such as update compatibilty of the software is important, which will allow the client to feel confident on the durability of the product.|...|...|W.I.P.|Good|
>> |**Function explanations**|For the client to know how the product works he will have to know the back end of every action that is possible on the game.|Every action is listed on this part and explaned how it works.|...|...|W.I.P.|Good|
>> |**Conclusion**|Conclusion will wrap up all the aspects of the technical specification|It will also allow the client to be satisfied about all the technical part of the final product.|...|...|W.I.P.|Good| 
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
>> </details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Movements|da
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> |Movements of Pac-Man|1|Pull code from Github desktop and try the movements of Pac-Man on the map verify if there is no bugs on the screen (teleportation, system failure, sprite going off limits...)|Push the limits of the sprite to the limits of the screen|**<span style = color:Green>Completed</span>**|Pac-Man stays within the limits of the screen, in both formats of screen (Full screen & )|Pac man stays within the screen and doesn't have any issue of teleportation.|The sprite of Pac-man tends to flicker as it moves around the screen.|**<span style = color:green>Fixed</span>**
>> |Movements of Pac-Man|2|Pull code from Github desktop and try the movements of Pac-Man on the map verify the controlability of the sprite. Use arrows on the keyboard to see if it's going the same direction as wanted|Chekc if the movements of Pac-man corresponds to the directions instructed by the keyboard arrows|**<span style = color:Green>Completed</span>**|Pac-Man moves in the direction wanted.| Pac man moves in the directed wanted on the screen with one press of the button(One click on the arrow key moves Pac-man to the end of the screen)| Direction works however when long pressed on one button Sprite disapears from screen!|**<span style = color:green>Fixed</span>**
>></details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
> Main menu 
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Main menu|1|Pull the code from github and look if the main menu is functional and visualy pleasing|check if the main menu buttons are functional, leads to another page, and are controlable with the arrows of the keyboard|**<span style = color:Orange>Work in progress</span>**|The main menu should be contrable and functional. In a general point of view it is visualy pleasing.|The main menu is contrable it is possible to move around from one button to another with the arrows.|Non complete due to the the main menu being nothing but a screen with three buttons and not visualy pleasing. In addition the buttons aren't functional they do not lead to another page such as the game or the settings|**<span style = color:Orange>Work in progress</span>**
>></details>


> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
> Settings muenu|da
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Settings menu|1|
>></details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Exit menu|da
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Exit  menu|1| 
>></details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>ScoringMovements|da
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Score system|
>></details>

> |Category|Description|Status|Expected result|Acutal result|Comment|Time|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>Maze|da
>><details>
>> <summary>Unit tests of the development phase</summary>
>>
>> |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|If issue, status|
>> |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>> Maze [^1]
>></details>

## Post Development (Final product)

The following tests will be made after that the final product is assembled togther, these tests will allow to decide if either the product is ready to be launched or not. These tests will make sure that there is no technical issues. These tests are based on what was promised in the functional specification and pushs the limits of the code before presenting the final product to the client.

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Game test**|General check of playability & if the game respects all the criterias|||||||
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Controlability**|Check if the buttons from the instructions work correctly, if all buttons corresponds to what it is supposingly controling|||||
>><details>
>>  <summary>Unit tasks of controlability</summary>

>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Loading**|Verify if the loading works|||Loading time not too long|||
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
>>  |:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>>  |Loading animation|Test number|Test|Loading time not too long|Status|Expected result|Actual result|Comment|
>></details>
>---

>|Category|Description|Status|Expected result|Actual result|Comment|Time spent|
>|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
>|**Effects**|Display of the pac man opening and closing||Animations of the ghost and pac man should be in the maze and not affecting the map except the points|||
>><details>
>>  <summary>Unit tasks of game test</summary>
>>  
>>  |Process|Test number|Test|Description|Status|Expected result|Actual result|Comment|Time spent|
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
> [^1]:
> Concerned part|Issue description |Status|Comments
> |:-:|:-:|:-:|:-:|
>  Maze|Circled areas aren't correct | **<span style = color:Orange>Work in progress</span>** | Map visuel aren't exactly what was expected.
> ![image](https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-7/assets/147847949/227d5b50-5dfb-472e-abaa-9a60137da0e6)


