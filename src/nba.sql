-- Initialize all the tables for the db
CREATE TABLE Coach(
  coachID CHAR(30),
  name CHAR(50),
  experience INTEGER,
  PRIMARY KEY (coachID)
);

grant select on Coach to public;

CREATE TABLE Team(
  teamID CHAR(50) NOT NULL,
  coachID CHAR(30),
  teamName CHAR(50),
  location CHAR(50),
  PRIMARY KEY (teamID),
  FOREIGN KEY (coachID)
    REFERENCES Coach(coachID)
    ON DELETE SET NULL
);

grant select on Team to public;

CREATE TABLE Team_Stats(
  tsID CHAR(50) NOT NULL,
  teamID CHAR(50) NOT NULL,
  win INTEGER,
  loss INTEGER,
  PRIMARY KEY (tsID, teamID),
  FOREIGN KEY (teamID) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE,
  CHECK (win >= 0 And win <= 82),
  CHECK (loss >= 0 And loss <= 82),
  CHECK ((win + loss) <= 82)
);

grant select on Team_Stats to public;

CREATE TABLE Game(
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

CREATE TABLE Player(
  playerID INTEGER NOT NULL,
  playerTeam CHAR(50) NOT NULL,
  firstName CHAR(50),
  lastName CHAR(50),
  position CHAR(50),
  age INTEGER,
  PRIMARY KEY (playerID, playerTeam),
  FOREIGN KEY (playerTeam) 
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Player to public;

CREATE TABLE Player_Stats(
  sID CHAR(50),
  pTeam CHAR (50) NOT NULL,
  player INTEGER NOT NULL,
  ppg DECIMAL,
  rpg DECIMAL,
  apg DECIMAL,
  PRIMARY KEY (sID, player, pTeam),
  FOREIGN KEY (player)
    REFERENCES Player(playerID)
    ON DELETE CASCADE,
  FOREIGN KEY (pTeam)
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Player_Stats to public;

CREATE TABLE Player_Contract(
  contractID CHAR(30),
  tID CHAR(50) NOT NULL,
  pID INTEGER NOT NULL,
  yearlySal INTEGER,
  yearsLeft INTEGER,
  PRIMARY KEY (contractID, tID, pID),
  FOREIGN KEY (pID)
    REFERENCES Player(playerID)
    ON DELETE CASCADE,
  FOREIGN KEY (tID)
    REFERENCES Team(teamID)
    ON DELETE CASCADE
);

grant select on Player_Contract to public;

commit;