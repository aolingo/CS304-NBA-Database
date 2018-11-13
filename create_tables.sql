/* Initialize tables and instances */

drop table Coach;
drop table Team;
drop table Team_Stats;
drop table Game;
drop table Player CASCADE CONSTRAINTS;
drop table Player_Stats;
drop table Player_Contract;

CREATE TABLE Coach
(
  coachID INTEGER NOT NULL,
  name CHAR(50),
  experience INTEGER,
  PRIMARY KEY (coachID),
);

grant select on Coach to public;

CREATE TABLE Team
(
  teamID CHAR(50) NOT NULL,
  coachID Integer NOT NULL,
  teamName CHAR(50),
  location CHAR(50),
  PRIMARY KEY (teamID),
  FOREIGN KEY (coachID)
    REFERENCES Coach(coachID)
    ON DELETE SET NULL
);

grant select on Team to public;

CREATE TABLE Team_Stats
(
  tsID INTEGER NOT NULL,
  wins INTEGER,
  wosses INTEGER,
  winLoss DECIMAL,
  ppg DECIMAL,
  papg DECIMAL,
  teamID CHAR(50) NOT NULL,
  PRIMARY KEY (tsID, teamID),
  FOREIGN KEY (teamID) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Team_Stats to public;

CREATE TABLE Game
(
  gameID INTEGER NOT NULL,
  homeTeam CHAR(50),
  awayTeam CHAR(50),
  homeScore INTEGER,
  awayScore INTEGER,
  CompanyName CHAR(30),
  PRIMARY KEY (gameID)
);

grant select on Game to public;

CREATE TABLE Player
(
  playerID INTEGER NOT NULL,
  name CHAR(50),
  position CHAR(50),
  teamID CHAR(50),
  PRIMARY KEY (playerID),
  FOREIGN KEY (Team) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE,
);

grant select on Player to public;

CREATE TABLE Player_Stats
(
  sID INTEGER NOT NULL,
  playerName CHAR(50),
  pts INTEGER,
  reb INTEGER,
  ast INTEGER,
  blk INTEGER,
  stl INTEGER,
  playerID INTEGER NOT NULL,
  PRIMARY KEY (sID),
  FOREIGN KEY (playerID)
    REFERENCES Player(playerID)
    ON DELETE CASCADE,
  FOREIGN KEY (playerName)
    REFERENCES Player(name)
    ON DELETE CASCADE
);

grant select on Player_Stats to public;

CREATE TABLE Player_Contract
(
  contractID INTEGER NOT NULL,
  length INTEGER,
  totalAmount INTEGER,
  playerID INTEGER NOT NULL,
  teamID CHAR(50) NOT NULL,
  PRIMARY KEY (contractID, playerID, teamID),
  FOREIGN KEY (playerID)
    REFERENCES Player(playerID)
    ON DELETE CASCADE,
  FOREIGN KEY (teamID)
    REFERENCES Team(teamID)
    ON DELETE SET NULL
);

grant select on Player_Contract to public;