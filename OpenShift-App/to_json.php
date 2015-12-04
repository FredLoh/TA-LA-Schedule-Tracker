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
*
* <hr>
* 
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

//Reqires php and the mysql extension to be installed--to install, run
//sudo apt-get install php5-cli
//and
//sudo apt-get install php5-mysql

function goWhere($type, $phrase1, $phrase2){
	
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
	else{
		echo "Please enter a valid search term";
	}
}

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

goWhere($_POST["type"], $_POST["phrase1"], $_POST["phrase2"]);

?>
