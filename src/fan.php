<!DOCTYPE html>
<html>
<style>
 .header img {
  float: left;
  width: 40px;
  height: 80px;
  background: #555;
}

.header h1 {
	position: relative;
	top: -15px;
  left: 20px;
  font-family:Helvetica;
}
</style>

<head>
        <title>NBA Database for Fans</title>
</head>

<body>
<div class="header">
  <img src="https://theundefeated.com/wp-content/uploads/2017/05/nba-logo.png" alt="NBA logo" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <h1>NBA Database for Fans</h1>
</div>
<br>
<form method="POST" action="fan.php">
<!-- Show all basic data from the database -->
<p>
<input type="submit" value="Show League Standings" name="displayStandings">
&nbsp;&nbsp;&nbsp;
<input type="submit" value="Show All Coaches" name="displayCoaches">
&nbsp;&nbsp;&nbsp;
<input type="submit" value="Show All Players and Stats" name="displayPlayers">
&nbsp;&nbsp;&nbsp;
<input type="submit" value="Show All Past Games" name="displayGames">
</p> 
</form>

<!-- Start of php file -->
<?php

$success = True; //keep track of errors so it redirects the page only if there are no errors
$db_conn = OCILogon("ora_v4w9a", "a14702147", "dbhost.ugrad.cs.ubc.ca:1522/ug");

function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
	//echo "<br>running ".$cmdstr."<br>";
	global $db_conn, $success;
	$statement = OCIParse($db_conn, $cmdstr); //There is a set of comments at the end of the file that describe some of the OCI specific functions and how they work

	if (!$statement) {
		echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
		$e = OCI_Error($db_conn); // For OCIParse errors pass the       
		// connection handle
		echo htmlentities($e['message']);
		$success = False;
	}

	$r = OCIExecute($statement, OCI_DEFAULT);
	if (!$r) {
		echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
		$e = oci_error($statement); // For OCIExecute errors pass the statementhandle
		echo htmlentities($e['message']);
		$success = False;
	} else {

	}
	return $statement;

}

function executeBoundSQL($cmdstr, $list) {
	/* Sometimes the same statement will be executed for several times ... only
	 the value of variables need to be changed.
	 In this case, you don't need to create the statement several times; 
	 using bind variables can make the statement be shared and just parsed once.
	 This is also very useful in protecting against SQL injection.  
      See the sample code below for how this functions is used */

	global $db_conn, $success;
	$statement = OCIParse($db_conn, $cmdstr);

	if (!$statement) {
		echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
		$e = OCI_Error($db_conn);
		echo htmlentities($e['message']);
		$success = False;
	}

	foreach ($list as $tuple) {
		foreach ($tuple as $bind => $val) {
			//echo $val;
			//echo "<br>".$bind."<br>";
			OCIBindByName($statement, $bind, $val);
			unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype

		}
		$r = OCIExecute($statement, OCI_DEFAULT);
		if (!$r) {
			echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
			$e = OCI_Error($statement); // For OCIExecute errors pass the statement handle
			echo htmlentities($e['message']);
			echo "<br>";
			$success = False;
		}
	}

}

function printStandings($result) { //prints the league standings (all Teams and corresponding Team_Stats sorted by Win)
	echo "<br>NBA Standings for the 2017-2018 Regular Season:<br>";
	echo "<table>";
	echo "<tr><th>Location</th><th>Team Name</th><th>Win</th><th>Loss</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
		echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>" . $row[2] . "</td><td>" . $row[3] . "</td></tr>"; //or just use "echo $row[0]" 
		
	}
	echo "</table>";
}

function printCoaches($result) { //prints all coaches in database
	echo "<br>All coaches currently in the league: <br>";
	echo "<table>";
	echo "<tr><th>Name</th><th>Experience</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
		echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] .  "</td></tr>"; //or just use "echo $row[0]" 
		
	}
	echo "</table>";
}

function printPlayers($result) { //prints all players and their stats from a select statement
	echo "<br>All players currently in the league: <br>";
	echo "<table>";
	echo "<tr><th>Age</th><th>First Name</th><th>Last Name</th><th>Position</th><th>Team</th><th>PPG</th><th>RPG</th><th>APG</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
		echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>" . $row[2] .  "</td><td>" . $row[3] . "</td><td>". $row[4] . "</td><td>". $row[5] . "</td><td>". $row[6] . "</td><td>". $row[7] . "</td></tr>"; //or just use "echo $row[0]" 
	}
	echo "</table>";
}

function printGames($result) { //prints all recorded games in the database
	echo "<br>Retrieved all games from the databse: <br>";
	echo "<table>";
	echo "<tr><th>GameID</th><th>Home</th><th>Home Score</th><th>Away</th><th>Away Score</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
		echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>" . $row[2] .  "</td><td>" . $row[3] . "</td><td>". $row[4] . "</td></tr>"; //or just use "echo $row[0]" 
	}
	echo "</table>";
}

// Connect Oracle...
if ($db_conn) {
if (array_key_exists('insertsubmit', $_POST)) {
			//Getting the values from user and insert data into the table
			$tuple = array (
				":bind1" => $_POST['insNo'],
				":bind2" => $_POST['insName'],
				":bind3" => $_POST['insPosition']
			);
			$alltuples = array (
				$tuple
			);
			executeBoundSQL("insert into tab1 values (:bind1, :bind2, :bind3)", $alltuples);
			OCICommit($db_conn);

		} else if (array_key_exists('updatesubmit', $_POST)) {
				// Update tuple using data from user
				$tuple = array (
					":bind1" => $_POST['oldName'],
					":bind2" => $_POST['newName'],
					":bind3" => $_POST['oldPosition'],
					":bind4" => $_POST['newPosition']
				);
				$alltuples = array (
					$tuple
				);
				executeBoundSQL("update tab1 set name=:bind2 where name=:bind1", $alltuples);
				executeBoundSQL("update tab1 set position=:bind4 where position=:bind3", $alltuples);
				OCICommit($db_conn);

			} else if (array_key_exists('deletesubmit', $_POST)) {
					$tuple = array (
					":bind1" => $_POST['deleteID'],
					);
					$alltuples = array (
						$tuple
					);
					executeBoundSQL("delete tab1 where nid=:bind1", $alltuples);
					OCICommit($db_conn);

				}	else if (array_key_exists('dostuff', $_POST)) {
						// Insert data into table...
						executePlainSQL("insert into tab1 values (10, 'Messi', 'Forward')");
						// Inserting data into table using bound variables
						$list1 = array (
							":bind1" => 6,
							":bind2" => "Bill",
							":bind3" => "Center"
						);
						$list2 = array (
							":bind1" => 7,
							":bind2" => "Me7o",
							":bind3" => "SF"
						);
						$allrows = array (
							$list1,
							$list2
						);
						executeBoundSQL("insert into tab1 values (:bind1, :bind2, :bind3)", $allrows); //the function takes a list of lists
						// Update data...
						//executePlainSQL("update tab1 set nid=10 where nid=2");
						// Delete data...
						//executePlainSQL("delete from tab1 where nid=1");
						OCICommit($db_conn);
					} 

				 else {
		// Select data...
		$result = executePlainSQL("select * from tab1");
		// printResult($result);
	}

	//Commit to save changes...
	OCILogoff($db_conn);
} else {
	echo "cannot connect";
	$e = OCI_Error(); // For OCILogon errors pass no handle
	echo htmlentities($e['message']);
}
?>
</body>
</html>