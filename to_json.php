
<?php
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

function course($x) {

	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');

	$sql = "select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
	from TAs, Classes, Sessions 
	where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and Classes.Classname like '%$x%'";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($array), "\n";

}

function name($x) {
	
	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');

	$sql = "select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
	from TAs, Classes, Sessions 
	where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and TAs.name like '%$x%'";

	$array = $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($array), "\n";

}

function insertClass($x) {

	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `Classes` (`Classname`) values ('$x');";
	$db->exec($sql);
}

function insertTA($x) {

	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `TAs` (`Name`) values ('$x');";
	$db->exec($sql);
}

function insertSession($a, $b, $c, $d, $e) {

//Variable meanings: a = TAID, b = ClassID, c = Day, d = Time, e = Location

	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "insert into `Sessions` (`TAID`, `ClassID`, `Day`, `Time`, `Location`) values ((select ID from TAs where Name like '$a'), (select ID from Classes where Classname like '$b'), '$c', '$d', '$e');";
	$db->exec($sql);

}

function deleteAll($x){

	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from Sessions
where TAID in (select ID from TAs where TAs.Name = '$x') or ClassID in (select ID from Classes where Classes.Classname = '$x');";
	$db->exec($sql);
}

function deleteTA($x){
	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from TAs
where Name = '$x';";
	$db->exec($sql);
}

function deleteClass($x){
	$db = new PDO('mysql:host=localhost;dbname=json_test;charset=utf8', 'root', 'user');
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$sql = "delete from Classes
where Classname = '$x';";
	$db->exec($sql);
}
//course("CSCI");

//name("Firstname Lastname");

//insertClass("MATH 1000");

//insertTA("Bob");

//insertSession("Bob", "MATH 1000", "M", "12:00 PM - 2:00 PM", "ECCR 1234");

//name("Bob");

//deleteAll("Bob");

?>
