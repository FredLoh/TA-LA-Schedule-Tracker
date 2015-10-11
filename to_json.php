
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

course("CSCI");

name("Firstname Lastname");

?>
