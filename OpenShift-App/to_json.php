<?php
/** @mainpage TA/LA Tracker 
*
* @authors Austin Holler, Tristan Hill, Marvin Tann, Frederik Lohner
*
* @section intro Introduction
* This provides the functionality of being able to query our MySQL database 
* easily and return meaningful JSON output. The entire project repository can be
* found at: <A HREF="https://github.com/FredLoh/TA-LA-Schedule-Tracker"> TA/LA Tracker</A>
*
* <hr>
* @section notes Release Notes
* - Updated queries and output to interface with mobile app better
* <hr>
* @section requirements Requirements
* Reqires php and the mysql extension to be installed--to install, run
* sudo apt-get install php5-cli
* and
* sudo apt-get install php5-mysql
*/

/*
 * to_json.php
 * 
 * Copyright 2015 user <user@cu-cs-vm>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

/*!
*This function tells which of the following functions should be used,
*and passes them the appropriate variables, if any.
*@param type This is a string that goWhere parses to determine which function to call.
*@param phrase1 This is an argument to pass to a function--either the name of a class or a TA.
*@param phrase2 This is a second argument for the getSessions function, which requires two, or addSession, which requires five.
@param phrase3 This is a third argument for the addSession function, which requires five.
@param phrase4 This is a fourth argument for the addSession function, which requires five.
@param phrase5 This is a fifth argument for the addSession function, which requires five.
* */
function goWhere($type, $phrase1, $phrase2, $phrase3, $phrase4, $phrase5){
	
	if(!strcmp($type, "name")){
		name($phrase1);
	}
	else if(!strcmp($type, "getTA")){
		allTAs();
	}
	else if(!strcmp($type, "TAsClasses")){
		TAsClasses($phrase1);
	}
	else if(!strcmp($type, "class")){
		course($phrase1);
	}
	else if(!strcmp($type, "getClasses")){
		allClasses();
	}
	else if(!strcmp($type, "ClassTAs")){
		classTAs($phrase1);
	}
	else if(!strcmp($type, "getSessions")){
		getSessions($phrase1, $phrase2);
	}
	else if(!strcmp($type, "addClass")){
		insertClass($phrase1);
	}
	else if(!strcmp($type, "addTA")){
		insertTA($phrase1);
	}
	else if(!strcmp($type, "delete")){
		deleteAll($phrase1);
	}
	else if(!strcmp($type, "addSession")){
		insertSession($phrase1, $phrase2, $phrase3, $phrase4, $phrase5);
	}
	else{
		echo "Please enter a valid search term";
	}
}

/*!
*This function finds all sessions for a single course. Defunct, and kept for reference.
*@param x This is the name of the course that is to be used as a search term.
* */
function course($x) {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
			from TAs, Classes, Sessions 
			where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and Classes.Classname like '%$x%'";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);
	
	$json = json_encode($array);
	
	for( $i = 0; $i < count($array); $i++){
			echo $array[$i], "-----", $i, "-----", "\n";
	}

	echo $json, "\n";

}

/*!
*This function finds all sessions for a single TA. Defunct, and kept for reference.
*@param x This is the name of the course that is to be used as a search term.
* */
function name($x) {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
			from TAs, Classes, Sessions 
			where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and TAs.name like '%$x%'";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);
	
	$json_array = explode(",", $json);
	
	for( $i = 0; $i < count($json_array); $i++){
			echo $json_array[$i], "-----", $i, "-----", "\n";
	}	

	echo $json, "\n";

}

/*!
*This function inserts a string into the 'Classes' mysql table.
*@param x This is the name of the course that is to be inserted into the table.
* */
function insertClass($x) {

	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `Classes` (`Classname`) values ('$x');";
	$db->exec($sql);
}

/*!
*This function inserts a string into the 'TAs' mysql table.
*@param x This is the name of the TA that is to be inserted into the table.
* */
function insertTA($x) {

	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `TAs` (`Name`) values ('$x');";
	$db->exec($sql);
}

/*!
*This function inserts a session into the 'Sessions' mysql table.
*@param a This is the name of the TA that runs the session in question.
*@param b This is the name of the class the session is about.
*@param c This is the day the session occurs.
*@param d This is the time of day the session occurs
*@param e This is location where the session will take place.
* */
function insertSession($a, $b, $c, $d, $e) {

//Variable meanings: a = TAID, b = ClassID, c = Day, d = Time, e = Location

	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `Sessions` (`TAID`, `ClassID`, `Day`, `Time`, `Location`) values ((select ID from TAs where Name like '$a'), (select ID from Classes where Classname like '$b'), '$c', '$d', '$e');";
	$db->exec($sql);

}

/*!
*This function deletes all sessions associated with a specific class or TA.
*@param x This is the name of the class or TA to be deleted.
* */
function deleteAll($x){

	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from Sessions
			where TAID in (select ID from TAs where TAs.Name = '$x') or ClassID in (select ID from Classes where Classes.Classname = '$x');";
	$db->exec($sql);
}

/*!
*This function deletes a TA from the 'TAs' mysql table.
*@param x This is the name of the TA that is to be deleted from the table.
* */
function deleteTA($x){
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from TAs
			where Name = '$x';";
	$db->exec($sql);
}

/*!
*This function deletes a class from the 'Classes' mysql table.
*@param x This is the name of the class that is to be deleted from the table.
* */
function deleteClass($x){
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);
	
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from Classes
			where Classname = '$x';";
	$db->exec($sql);
}

/*!
*This function prints out all the class names logged in the 'Classes' mysql table.
* */
function allClasses() {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select Classname from Classes";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);	

	echo $json, "\n";

}

/*!
*This function prints out all the TA names logged in the 'TAs' mysql table.
* */
function allTAs() {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select Name from TAs";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);	

	echo $json, "\n";

}

/*!
*This function prints all TAs that are associated with a given class.
*@param x This is the name of the class to be used as a search term.
* */
function classTAs($x) {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select distinct TAs.Name
			from TAs, Classes, Sessions 
			where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and (Classes.Classname like '%$x%');";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);	

	echo $json, "\n";

}

/*!
*This function prints all classes that a given TA is associated with.
*@param x This is the name of the TA to be used as a search term.
* */
function TAsClasses($x) {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select distinct Classes.Classname
			from TAs, Classes, Sessions 
			where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and (TAs.name like '%$x%');";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);	

	echo $json, "\n";

}

/*!
*This function prints out all the sessions a given TA runs for a given class.
*@param x This is the name of the TA to be used as a search term.
*@param y This is the name of the class to be used as a search term.
* */
function getSessions($x, $y) {
	
	define('DB_HOST', getenv('OPENSHIFT_MYSQL_DB_HOST'));
	define('DB_PORT',getenv('OPENSHIFT_MYSQL_DB_PORT')); 
	define('DB_USER',getenv('OPENSHIFT_MYSQL_DB_USERNAME'));
	define('DB_PASS',getenv('OPENSHIFT_MYSQL_DB_PASSWORD'));
	define('DB_NAME',getenv('OPENSHIFT_GEAR_NAME'));

	$dsn = 'mysql:dbname='.DB_NAME.';host='.DB_HOST.';port='.DB_PORT;
	$db = new PDO($dsn, DB_USER, DB_PASS);

	$sql = "select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
			from TAs, Classes, Sessions 
			where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and (TAs.name like '%$x%' and Classes.Classname like '%$y%');";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	$json = json_encode($array);	

	echo $json, "\n";

}

goWhere($_POST["type"], $_POST["phrase1"], $_POST["phrase2"], $_POST["phrase3"], $_POST["phrase4"], $_POST["phrase5"]);

?>
