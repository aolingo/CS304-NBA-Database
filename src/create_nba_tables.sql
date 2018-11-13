/* Initialize tables and instances */

drop table Coach;
drop table Team;
drop table Team_Stats;
drop table Game;
drop table Player;
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
  win INTEGER,
  loss INTEGER,
  teamID CHAR(50) NOT NULL,
  PRIMARY KEY (tsID, teamID),
  FOREIGN KEY (teamID) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE,
  CHECK (win >= 0 And win <= 82),
  CHECK (loss >= 0 And loss <= 82),
  CHECK ((win + loss) <= 82)
);

grant select on Team_Stats to public;

CREATE TABLE Game
(
  gameID INTEGER NOT NULL,
  homeTeamID CHAR(50),
  awayTeamID CHAR(50),
  homeScore INTEGER,
  awayScore INTEGER,
  PRIMARY KEY (gameID),
  FOREIGN KEY (homeTeamID) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE,
  FOREIGN KEY (awayTeamID) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Game to public;

CREATE TABLE Player
(
  playerID INTEGER NOT NULL,
  playerTeam CHAR(50),
  pcID CHAR(50),
  firstName CHAR(50),
  lastName CHAR(50),
  position CHAR(50),
  age CHAR(50),
  PRIMARY KEY (playerID),
  FOREIGN KEY (teamID) 
    REFERENCES Team(playerTeam)
    ON DELETE CASCADE,
  FOREIGN KEY (pcID) 
    REFERENCES Player_Contract(contractID)
    ON DELETE CASCADE
);

grant select on Player to public;

CREATE TABLE Player_Stats
(
  sID INTEGER NOT NULL,
  player INTEGER NOT NULL,
  pts INTEGER,
  reb INTEGER,
  ast INTEGER,
  PRIMARY KEY (sID),
  FOREIGN KEY (player)
    REFERENCES Player(playerID)
    ON DELETE CASCADE
);

grant select on Player_Stats to public;

CREATE TABLE Player_Contract
(
  contractID INTEGER NOT NULL,
  pID INTEGER NOT NULL,
  tID CHAR(50) NOT NULL,
  yearlySal INTEGER,
  contractLength INTEGER,
  PRIMARY KEY (contractID, pID, tID),
  FOREIGN KEY (pID)
    REFERENCES Player(playerID)
    ON DELETE CASCADE,
  FOREIGN KEY (tID)
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Player_Contract to public;