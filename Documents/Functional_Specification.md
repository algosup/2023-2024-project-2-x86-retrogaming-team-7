
# Functional Specification Document

## x86x16bits Retro-gaming

- [Functional Specification Document](#functional-specification-document)
  - [x86x16bits Retro-gaming](#x86x16bits-retro-gaming)
  - [Project Overview](#project-overview)
    - [Project Scope](#project-scope)
      - [Project in scope](#project-in-scope)
      - [Project out of scope](#project-out-of-scope)
    - [Project Goals](#project-goals)
      - [Goals](#goals)
      - [Non-Goals](#non-goals)
  - [Functional Requirements](#functional-requirements)
    - [1. x86-16bits environment](#1-x86-16bits-environment)
      - [Description](#description)
      - [Acceptance Criteria](#acceptance-criteria)
    - [2. Pac-Man like](#2-pac-man-like)
      - [Description](#description-1)
        - [Acceptance Criteria](#acceptance-criteria-1)
    - [\[Continue listing requirements...\]](#continue-listing-requirements)
- [Design](#design)
  - [Non-Functional Requirements](#non-functional-requirements)
    - [1. Performance](#1-performance)
    - [2. Security](#2-security)
  - [Use Cases](#use-cases)
  - [Assumptions and Constraints](#assumptions-and-constraints)
  - [Dependencies](#dependencies)
  - [Risks](#risks)
  - [Change Control](#change-control)
  - [Approval](#approval)
  - [Revision History](#revision-history)
    - [Glossary](#glossary)

---


**| Member of the project |**

| Guillaume DESPAUX | Project Manager

| Michel RIFF | Project Manager

| Lucas AUBARD | Technical Lead

| Enzo GUILLOUCHE | Junior Software Engineer

| Elone DELILLE | Junior Software Engineer

| Ian LAURENT | Quality Assurance


## Project Overview

ALGOSUP asked us to recreate an old video game, which is the game called "Pac-Man". We will make it with some features, in an environment called MS-DOS (x86-16bits) and in assembly language [^1].
This project started the Monday 6th November and its deadline is Thursday 21th December.

---
 So what is Pac-Man ? 

![PAC-MAN](https://openseauserdata.com/files/7980c0c921ad90ecb7deadf1aefeda41.png)

Pac-Man is a maze-based and a singleplayer video game set in a brightly colored, released in 1980 in Japan. The player takes control of a yellow character, known as Pac-Man. The objective of the game is to clear all the dots from the maze while avoiding four colorful ghosts who are out to catch Pac-Man. The player earns points by consuming dots and, occasionally, larger dots, which temporarily turn the ghosts vulnerable, then Pac-Man can eat them to earn more points.

---

### Project Scope

#### Project in scope

- Recreate a game that makes people feel the joy of playing. 
- To define the core gameplay mechanics, rules, and objectives for the Pac-Man game, including the movement of the Pac-Man character, the behavior of ghosts and collecting pellets.
- To avoid all the copyright elements of the game like the yellow character sprite and his name : "Pac-Man", the ghost sprite and the soundtracks of the game. We need to change those elements. 
- To add some features as the difficulty and some sprites, to not just remake the game without changes (excepting the copyrights).
- To set performance goals, such as achieving a target frame rate and ensuring smooth gameplay.

#### Project out of scope

- Make a game that is not pleasant to play. 
- To create the game that have another objective of the main game.
- To create the game in another language than assembly. 
- To develop the game that does not work/launch. 

---

### Project Goals

#### Goals
- To change the sprites
- To change the music
- To give the possibility to change the difficulty
- To create new maps
- To make the game smooth and playable
- To make a compatible game

#### Non-Goals
- To add boss stages
- To add new game mode

## Functional Requirements

### 1. x86-16bits environment

#### Description

For this project we need to use the software DOSBox which is a simulator of a MS-DOS environment.

#### Acceptance Criteria

- Each system will have to use this software to play the game.
- The DOSBox emulator will be integrated in an installer, supplied when we will be going to bring out this game. 

### 2. Pac-Man like

#### Description

We need to create a game which contains the same mecanics of gameplay than the game Pac-Man, using new models and soundtracks due to copyright. 


##### Acceptance Criteria

- The game must be complete with no issue, crash, bug or glitch during all the user experience.

#
#### 2.1 Main menu
The main menu is the menu you land on when you launch the game. It allows the player to choose to play, to change his controls in the settings. 

#### 2.2 Start
The game starts and the player can play until he looses all his lives.

#### 2.3 Game over
If the player looses all his lives, it's game over, then he comes back to the main menu.

#### 2.4 "Control" menu as the settings
The settings is accessible from the main menu, it has to change the player's keybinds as he would like. 

#### 2.5 Credits
The credits are accessible from the main menu, they serve to credit the people who worked on the project, from close or far.

#### 2.6 Map
When the player starts the game, it will take place in a map. The whole map deals with all the maze, and it will all displayed on the screen. 

#### 2.7 Pac-Man
The famous character Pac-Man is the playable one in the game. The player who controls him can change his direction, while he's moving, in 4 directions (up, left, right and down), he also can eat dots by just going on them.

#### 2.8 Collisions/Hitboxes 
In Pac-Man, the payable character has hitbox with the map, the objects he can interact with, the enemies. 

#### 2.9 Enemies 
The enemies are the 4 ghosts in the game, each has a special color to discern it from the others. Their goal is to follow Pac-Man and catch him, and each ghost has its own pattern.



#
### [Continue listing requirements...]

# Design

## Non-Functional Requirements

This section should detail non-functional requirements, which include performance, security, usability, and other quality attributes.

### 1. Performance

<!-- [Performance Requirement Title] -->

- [Describe the performance requirement, such as response time, scalability, or throughput.]
- [E.g., "The system should be able to handle 100 concurrent users with response times under 2 seconds."]

### 2. Security

<!-- [Security Requirement Title] -->

- [Describe the security requirements, such as authentication, authorization, encryption, and data protection.]
- [E.g., "User passwords must be securely hashed and stored in the database."]

<!-- [Continue listing non-functional requirements...] -->

## Use Cases

Provide use case diagrams and descriptions to illustrate how users will interact with the system.

## Assumptions and Constraints

List any assumptions and constraints that may impact the project's development and implementation.

## Dependencies

Identify any external dependencies that the project relies on, such as third-party APIs, libraries, or hardware.

## Risks

- Not deliver the final product on time.
- Make the game not working/launching on the customer's hardware.
- Do not respect the legislations regarding the copyrights. 

## Change Control

Outline the process for managing and approving changes to the functional specification.

## Approval

The undersigned stakeholders hereby approve this functional specification document.

- [Name and Signature of Stakeholder 1]
- [Name and Signature of Stakeholder 2]
- ...

## Revision History

Record changes made to the document, including dates, descriptions, and the names of those who made the changes.

### Glossary


[^1]: Assembly language is a low-level programming language that is used to write programs for a computer's central processing unit (CPU). It is a human-readable representation of machine code, which is the binary code that a CPU can directly execute. Assembly language provides a symbolic way to represent the CPU's instructions, making it easier for programmers to write and understand low-level code while still having a one-to-one correspondence with the actual machine code.


[^2]: A hitbox is an invisible shape bounding all or part of a model (in a video game, etc.) used in collision detection to determine whether another object collides with the model.

[^3]: In software engineering, a pattern is a reusable behavior of a Non-Playable Character (NPC), which can be overuse by the player to beat a boss for example.

[^4]: 

[^5]: 

[^6]: 


[def]: 