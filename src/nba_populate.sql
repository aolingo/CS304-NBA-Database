-- Insert Coaches (12 for now)
insert into Coach values
('hc1', 'Dwane Casey', 10);

insert into Coach values
('hc2', 'Brad Stevens', 6);

insert into Coach values
('hc3', 'Brett Brown', 6);

insert into Coach values
('hc4', 'Tyronn Lue', 4);

insert into Coach values
('hc5', "Mike D'Antoni", 15);

insert into Coach values
('hc6', 'Steve Kerr', 5);

insert into Coach values
('hc7', 'Terry Stotts', 11);

insert into Coach values
('hc8', 'Billy Donovan', 4);

insert into Coach values
('hc9', 'Gregg Popovich', 23);

insert into Coach values
('hc10', 'Stan Van Gundy', 12);

insert into Coach values
('hc11', 'Byron Scott', 15);

insert into Coach values
('hc12', 'George Karl', 27);

-- Insert Teams (10 teams for now)
insert into Team values
( 'TOR', 'hc1', 'Raptors', 'Toronto');

insert into Team values
( 'BOS', 'hc2', 'Celtics', 'Boston' );

insert into Team values
( 'PHI', 'hc3', '76ers', 'Philadelphia');

insert into Team values
( 'CLE', 'hc4', 'Cavaliers', 'Cleveland');

insert into Team values
( 'HOU', 'hc5', 'Rockets', 'Houston');

insert into Team values
( 'GSW', 'hc6', 'Warriors', 'Oakland');

insert into Team values
( 'POR', 'hc7', 'Trailblazers', 'Portland');

insert into Team values
( 'OKC', 'hc8', 'Thunder', 'Oklahoma City');

insert into Team values
( 'SAS', 'hc9', 'Spurs', 'San Antonio');

insert into Team values
( 'DET', 'hc10', 'Pistons', 'Detroit');

-- Insert Team Stats
insert into Team_Stats values
('ts1', 'TOR', 59, 23);

insert into Team_Stats values
('ts2', 'BOS', 55, 27);

insert into Team_Stats values
('ts3', 'PHI', 52, 30);

insert into Team_Stats values
('ts4', 'CLE', 50, 32);

insert into Team_Stats values
('ts5', 'HOU', 65, 17);

insert into Team_Stats values
('ts6', 'GSW', 58, 24);

insert into Team_Stats values
('ts7', 'POR', 49, 33);

insert into Team_Stats values
('ts8', 'OKC', 48, 34);

insert into Team_Stats values
('ts9', 'SAS', 47, 35);

insert into Team_Stats values
('ts10', 'DET', 39, 43);

-- Insert Games (5 for now)
-- game id is of format: year-month-day-game# that day
insert into Game values
(2017102101, 'TOR', 'PHI', 128, 94);

insert into Game values
(2017111601, 'BOS', 'GSW', 92, 88);

insert into Game values
(2018020301, 'CLE', 'HOU', 88, 120);

insert into Game values
(2018032501, 'OKC', 'POR', 105, 108);

insert into Game values
(2017120401, 'SAS', 'DET', 96, 93);

-- Insert Players and their Stats (2-5 per team for now)
-- Raptors
insert into Player values
(10, 'TOR', 'DeMar', 'DeRozan', 'SG', 28);
insert into Player values
(7, 'TOR', 'Kyle', 'Lowry', 'PG', 31);
insert into Player values
(9, 'TOR', 'Serge', 'Ibaka', 'PF', 28);
insert into Player values
(17, 'TOR', 'Jonas', 'Valanciunas', 'C', 25);
insert into Player values
(3, 'TOR', 'OG', 'Anunoby', 'SF', 20);
insert into Player_Stats values
('dderozan17', 'TOR', 10, 23.0, 3.9, 5.2);
insert into Player_Stats values
('klowry17', 'TOR', 7, 16.2, 5.6, 6.9);
insert into Player_Stats values
('sibaka17', 'TOR', 9, 12.6, 6.3, 0.8);
insert into Player_Stats values
('jvalanciunas17', 'TOR', 17, 12.7, 8.6, 1.1);
insert into Player_Stats values
('og17', 'TOR', 3, 5.9, 2.5, 0.7);
-- Celtics
insert into Player values
(11, 'BOS', 'Kyrie', 'Irving', 'PG', 25);
insert into Player values
(7, 'BOS', 'Jaylen', 'Brown', 'SG', 21);
insert into Player values
(0, 'BOS', 'Jayson', 'Tatum', 'PG', 19);
insert into Player values
(42, 'BOS', 'Al', 'Horford', 'C', 31);
insert into Player values
(12, 'BOS', 'Terry', 'Rozier', 'PG', 23);
insert into Player_Stats values
('kirving17', 'BOS', 11, 24.4, 3.8, 5.1);
insert into Player_Stats values
('jbrown17', 'BOS', 7, 14.5, 4.9, 1.6);
insert into Player_Stats values
('jtatum17', 'BOS', 0, 13.9, 5.0, 1.6);
insert into Player_Stats values
('ahorford17', 'BOS', 42, 12.9, 7.4, 4.7);
insert into Player_Stats values
('trozier17', 'BOS', 12, 11.3, 4.7, 2.9);
-- 76ers
insert into Player values
(12, 'PHI', 'Joel', 'Embiid', 'C', 23);
insert into Player values
(25, 'PHI', 'Ben', 'Simmons', 'PG', 21);
insert into Player values
(33, 'PHI', 'Robert', 'Covington', 'SF', 27);
insert into Player_Stats values
('jembiid17', 'PHI', 12, 22.9, 11.0, 3.2);
insert into Player_Stats values
('bsimmons17', 'PHI', 25, 15.8, 8.1, 8.2);
insert into Player_Stats values
('rcovington17', 'PHI', 33, 12.6, 5.4, 2.0);
-- Cavaliers
insert into Player values
(23, 'CLE', 'LeBron', 'James', 'SF', 33);
insert into Player values
(0, 'CLE', 'Kevin', 'Love', 'PF', 29);
insert into Player_Stats values
('lbj17', 'CLE', 23, 27.5, 8.6, 9.1);
insert into Player_Stats values
('klove17', 'CLE', 0, 17.6, 9.3, 1.7);
-- Pistons
insert into Player values
(23, 'DET', 'Blake', 'Griffin', 'PF', 28);
insert into Player values
(0, 'DET', 'Andre', 'Drummond', 'C', 24);
insert into Player_Stats values
('bgriffin17', 'DET', 23, 19.8, 6.6, 6.2);
insert into Player_Stats values
('adrummond17', 'DET', 0, 15.0, 16.0, 3.0);
-- Rockets
insert into Player values
(13, 'HOU', 'James', 'Harden', 'SG', 28);
insert into Player values
(3, 'HOU', 'Chris', 'Paul', 'PG', 32);
insert into Player_Stats values
('jharden17', 'HOU', 13, 30.4, 5.4, 8.8);
insert into Player_Stats values
('cpaul17', 'HOU', 3, 18.6, 5.4, 7.9);
-- Warriors
insert into Player values
(30, 'GSW', 'Stephen', 'Curry', 'PG', 29);
insert into Player values
(35, 'GSW', 'Kevin', 'Durant', 'SF', 29);
insert into Player_Stats values
('scurry17', 'GSW', 30, 26.4, 5.1, 6.1);
insert into Player_Stats values
('kdurant17', 'GSW', 35, 26.4, 6.8, 5.4);
-- Trailblazers
insert into Player values
(0, 'POR', 'Damian', 'Lillard', 'PG', 27);
insert into Player values
(3, 'POR', 'CJ', 'McCollum', 'SG', 26);
insert into Player_Stats values
('dlillard17', 'POR', 0, 26.9, 4.5, 6.6);
insert into Player_Stats values
('cjmccollum17', 'POR', 3, 21.4, 4.0, 3.4);
-- Thunder
insert into Player values
(0, 'OKC', 'Russell', 'Westbrook', 'PG', 29);
insert into Player values
(13, 'OKC', 'Paul', 'George', 'SF', 27);
insert into Player_Stats values
('rwestbrook17', 'OKC', 0, 25.4, 10.1, 10.3);
insert into Player_Stats values
('pgeorge17', 'OKC', 13, 21.9, 5.7, 3.3);
-- Spurs
insert into Player values
(12, 'SAS', 'LaMarcus', 'Aldridge', 'C', 32);
insert into Player values
(2, 'SAS', 'Kawhi', 'Leonard', 'SF', 26);
insert into Player_Stats values
('laldridge17', 'SAS', 12, 23.1, 8.5, 2.0);
insert into Player_Stats values
('kleonard17', 'SAS', 2, 16.2, 4.7, 2.3);

-- Insert each Player's corresponding contract
insert into Player_Contract values('pc1', 'TOR', 10, 27739975, 3);
insert into Player_Contract values('pc2', 'TOR', 7, 28903704, 2);
insert into Player_Contract values('pc3', 'TOR', 9, 20061729, 2);
insert into Player_Contract values('pc4', 'TOR', 17, 15460675, 2);
insert into Player_Contract values('pc5', 'TOR', 3, 1645200, 4);
insert into Player_Contract values('pc6', 'BOS', 11, 18868626, 1);
insert into Player_Contract values('pc7', 'BOS', 7, 4956480, 2);
insert into Player_Contract values('pc8', 'BOS', 0, 5645400, 3);
insert into Player_Contract values('pc9', 'BOS', 42, 27734405, 2);
insert into Player_Contract values('pc10', 'BOS', 12, 1988520, 1);
insert into Player_Contract values('pc11', 'PHI', 12, 6100266, 3);
insert into Player_Contract values('pc12', 'PHI', 25, 6168840, 2);
insert into Player_Contract values('pc13', 'PHI', 33, 16698103, 4);
insert into Player_Contract values('pc14', 'CLE', 23, 33285709, 0);
insert into Player_Contract values('pc15', 'CLE', 0, 22642350, 0);
insert into Player_Contract values('pc16', 'DET', 23, 29512900, 4);
insert into Player_Contract values('pc17', 'DET', 0, 23775506, 3);
insert into Player_Contract values('pc18', 'HOU', 13, 27739975, 3);
insert into Player_Contract values('pc19', 'HOU', 3, 24268959, 0);
insert into Player_Contract values('pc20', 'GSW', 30, 34682550, 4);
insert into Player_Contract values('pc21', 'GSW', 35, 25000000, 1);
insert into Player_Contract values('pc22', 'POR', 0, 26153057, 3);
insert into Player_Contract values('pc23', 'POR', 3, 23962573, 3);
insert into Player_Contract values('pc24', 'OKC', 0, 28299399, 3);
insert into Player_Contract values('pc25', 'OKC', 13, 19300000, 0);
insert into Player_Contract values('pc26', 'SAS', 12, 27739975, 3);
insert into Player_Contract values('pc27', 'SAS', 2, 18868625, 1);