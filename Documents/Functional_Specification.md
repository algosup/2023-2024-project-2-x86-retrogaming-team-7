
# Functional Specification Document

## Project Name: [x86x16bits Retro-gaming] 

- [Functional Specification Document](#functional-specification-document)
  - [Project Name: \[x86x16bits Retro-gaming\]](#project-name-x86x16bits-retro-gaming)
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
      - [\[Performance Requirement Title\]](#performance-requirement-title)
    - [2. Security](#2-security)
      - [\[Security Requirement Title\]](#security-requirement-title)
    - [\[Continue listing non-functional requirements...\]](#continue-listing-non-functional-requirements)
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

---
 So what is Pac-Man ? 

![PAC-MAN](https://ocremix.org/files/images/games/arc/2/pac-man-arc-title-80834.jpg)

Pac-Man is a maze-based and a singleplayer video game set in a brightly colored, released in 1980 in Japan. The player takes control of a yellow character, known as Pac-Man. The objective of the game is to clear all the dots from the maze while avoiding four colorful ghosts who are out to catch Pac-Man. The player earns points by consuming dots and, occasionally, larger dots, which temporarily turn the ghosts vulnerable, then Pac-Man can eat them to earn more points.

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


### Project Goals


#### Goals

#### Non-Goals


## Functional Requirements

### 1. x86-16bits environment

#### Description

For this project we need to use the software DOSBox which is a simulator of a MS-DOS envrinonment.

#### Acceptance Criteria

- Each system should be available to use this software for complete this project.

### 2. Pac-Man like

#### Description

We need to create a game which contains the same mecanics of gameplay than the game Pac-Man, using new models and song due to copyright. 

#### Acceptance Criteria

- The game must be complete with no issues, crash, bug or glitch during all the user experience.

### [Continue listing requirements...]

# Design

## Non-Functional Requirements

This section should detail non-functional requirements, which include performance, security, usability, and other quality attributes.

### 1. Performance

#### [Performance Requirement Title]

- [Describe the performance requirement, such as response time, scalability, or throughput.]
- [E.g., "The system should be able to handle 100 concurrent users with response times under 2 seconds."]

### 2. Security

#### [Security Requirement Title]

- [Describe the security requirements, such as authentication, authorization, encryption, and data protection.]
- [E.g., "User passwords must be securely hashed and stored in the database."]

### [Continue listing non-functional requirements...]

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


[^2]: 

[^3]: 

[^4]: 

[^5]: 

[^6]: 


[def]: 