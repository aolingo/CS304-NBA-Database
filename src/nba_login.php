<!DOCTYPE HTML>
<html> 

<body>
	<label><p>NBA Employee Login Portal</p></label>
	<br><br>

<form method="POST" action="nba_login.php" >
<label><p>Username:</p></label> <input type="text" name="user"><br>
<label><p>Password:</p></label> <input type="password" name="pass"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br><br>
<input type="submit" name = "ulogin" value = "Login"> 
</form>

<?php

//this tells the system that it's no longer just parsing 
//html; it's now parsing PHP

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
	/* Sometimes a same statement will be excuted for severl times, only
	 the value of variables need to be changed.
	 In this case you don't need to create the statement several times; 
	 using bind variables can make the statement be shared and just 
	 parsed once. This is also very useful in protecting against SQL injection. See example code below for       how this functions is used */

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
			$e = OCI_Error($statement); // For OCIExecute errors pass the statementhandle
			echo htmlentities($e['message']);
			echo "<br>";
			$success = False;
		}
	}

}

function printResult($result) { //prints results from a select statement
	
	echo "<table>";
	echo "<br>";
	echo "<tr><th>username</th><th>password</th><th>recovery</th><th>member_since</th><th>phone</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {

		echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>". $row[2] . "</td><td>". $row[3] . "</td><td>". $row[4] . "</td></tr>"; //or just use "echo $row[0]" 
	}

	echo "<br>";
	echo "</table>";

}

// Connect Oracle...0
if ($db_conn) {



	 

	if (array_key_exists('ulogin', $_POST)) {
		//echo "you just clicked login";
		$user = $_POST['user'];
		$pass = $_POST['pass'];

			/*executePlainSQL("insert into account values ('a', '1',null,null,null)");
			executePlainSQL("insert into account_admin values ('a', null)");*/
		/*
			echo "<br>User accounts<br>";	
			$u1 = executePlainSQL("select * from account a, account_user au where a.username = au.username");			
		    printResult($u1);
			
			echo "<br>Admin accounts<br>";	
			$a1 = executePlainSQL("select * from account a, account_admin ad where a.username = ad.username");
		    printResult($a1);*/
			
			$result = executePlainSQL("SELECT username from account where username = '$user' AND password = '$pass'");
			$admin = executePlainSQL("SELECT username from account_admin where username = '$user'");
			$row = OCI_Fetch_Array($result, OCI_BOTH);
			$row_ad = OCI_Fetch_Array($admin, OCI_BOTH);
		
		
		
			if($row[0]!=NULL){
				
			if($row_ad[0] != NULL){
				//echo "login through admin account";
				setcookie("admin",true);
				setcookie("username", $user);
				header("location:admin.php");
				}
				
			else{
				//echo "login through normal account";
			setcookie("username", $user);
			//header("location:http://www.ugrad.cs.ubc.ca/~v4w9a/main.php");
			header("location:nba_employees.php");
			} 
			}
			else{print("<script>window.alert('Invalid Username or Password, please try again');</script>");
     	
     } 
		OCICommit($db_conn);

	} else
		if (array_key_exists('register', $_POST)) {
			
			//echo "you just clicked register";
			$userreg = $_POST['user'];
			$passreg = $_POST['pass'];
			
			
			if (!empty($userreg) || !empty($passreg)) {
				
				$check = executePlainSQL("select username from account where username = '$userreg'");
				$rowcheck = OCI_Fetch_Array($check, OCI_BOTH);
				
				if($rowcheck[0]!= NULL){	
				echo "<br>username    " . $userreg . "    already exists<br>";

			
			}
				
			else {//Getting the values from user and insert data into the table
			$tuple = array (
				":bind1" => $_POST['user'],
				":bind2" => $_POST['pass']
			);
			$alltuples = array (
				$tuple
			);


			executeBoundSQL("insert into account values (:bind1, :bind2,null,null,null)", $alltuples);
			executeBoundSQL("insert into account_user values (:bind1, null,null)", $alltuples);
			
			
			
			/*
			$result = executePlainSQL("select * from account");
				printResult($result);*/
			}
			
			}
			
			else {print("<script>window.alert('Invalid username or password (cannot be empty)');</script>");
				//echo "<br>Invalid username or password (cannot be NULL)<br>";
				}
			
			OCICommit($db_conn);

			print("<script>window.alert('Registered successfully');</script>");
			


		} else
			if (array_key_exists('updatesubmit', $_POST)) {
				// Update tuple using data from user
				$tuple = array (
					":bind1" => $_POST['oldName'],
					":bind2" => $_POST['newName']
				);
				$alltuples = array (
					$tuple
				);
				executeBoundSQL("update tab1 set name=:bind2 where name=:bind1", $alltuples);
				OCICommit($db_conn);

			}

	if ($_POST && $success) {
		//POST-REDIRECT-GET -- See http://en.wikipedia.org/wiki/Post/Redirect/Get
		//header("location: oracle-test.php");
	} else {
		// Select data...
		// $result = executePlainSQL("select * from tab1");
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
