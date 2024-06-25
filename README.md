# League Table Project Documentation

You can view detailed documentation at the path: cross-platform/EPL_Season_Table/doc/api/index.html.

## Description
This project is a mobile application written in Flutter using the Dart programming language. It will use an API to display all the football teams of the EPL and La Liga on the main page. When clicking on each team, a new window will open, showing the team's overall statistics as well as home and away match statistics.

## Features
Main Page:
- League switch element
- Display the logo and name of each team
- Show the current league standing of all teams
- Display points accumulated throughout the season
- Show the number of wins, losses, and draws

Detailed Team Statistics:
- Overall Statistics:
  - Number of matches played
  - Number of wins, draws, and losses
  - Number of goals scored and conceded
  - Goal difference
  - Total points accumulated

- Home Match Statistics:
  - Number of matches played
  - Number of wins, draws, and losses
  - Number of goals scored and conceded
  - Goal difference

- Away Match Statistics:
  - Number of matches played
  - Number of wins, draws, and losses
  - Number of goals scored and conceded
  - Goal difference

## Interaction Between Classes
Details on how classes interact with each other are provided in the documentation.
![image](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/e7e05510-7c3a-4833-bfea-ba86bc99bcc7)

## Getting Started
1. Clone the project repository from Git:
git clone https://github.com/VladyslavMarii/cross-platform.git
2. For web mode: Select the web browser in the Flutter Device Section of your IDE and click run.
3. For Android mode: Launch the Android emulator through Device Manager (e.g., Pixel 3a) and use the extended controls of the emulator.

## Example of the Application in Web Version
![Main page of the web version](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/c0955b4a-f56b-4dd9-ab43-935dac057439)

To view detailed information about a team, click on the team to navigate to the next screen.

![Team selection screen](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/809813e3-74ab-4458-8abc-5e2ba5e5e4f7)

On this screen, you will find detailed information about the team "ARSENAL," and you can switch between tabs for home games, away games, and all games.

![Detailed team information screen](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/d4152455-3b0b-44ba-a23f-2b45b8a72d1c)

If you click on the league name on the main page, you can select another league, specifically La Liga.

![League selection screen](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/f965b37b-3c6f-4807-9e18-427be046bb81)

Clicking on it will take you to a similar screen with data for La Liga teams. As with the EPL, clicking on a team will navigate to the detailed information page for that team.

![La Liga team information screen](https://github.com/VladyslavMarii/SoccerSeasonTable/assets/64550027/678ff549-8be0-4ad8-a40b-600ccf9f4584)
