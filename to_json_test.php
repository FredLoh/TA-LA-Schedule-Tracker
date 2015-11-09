<?php

//The unit tests for to_json.php. To run, one must install phpunit, and
//also be running php version 5.6.

//To install phpunit, run the following commands:
//wget https://phar.phpunit.de/phpunit.phar
//chmod +x phpunit.phar
//sudo mv phpunit.phar /usr/local/bin/phpunit
//phpunit --version

//To run the tests, run 'phpunit to_json_test.php'

require_once('to_json.php');

class to_json_test extends PHPUnit_Framework_TestCase
{
	public function setUp(){ }
	public function tearDown(){ }

	public function testCourse()
	{
		//Tests the course search function of to_json by comparing 
		//course("CSCI")'s output to the expected output JSON.
		$this->expectOutputString('[{"Name":"Firstname2 Lastname2","Classname":"CSCI 2400: Computer Systems","Day":"W,Th,F","Time":"10:00 AM - 1:30 PM","Location":"ECCR 123"},{"Name":"Firstname3 Lastname3","Classname":"CSCI 3753: Operating Systems","Day":"M,W,F","Time":"10:30 AM - 3:00 PM","Location":"ECCS 200"},{"Name":"Firstname3 Lastname3","Classname":"CSCI 3308: Methods + Tools","Day":"Tu,Th,F","Time":"2:00 PM - 5:00 PM","Location":"ECCS 200"},{"Name":"Firstname4 Lastname4","Classname":"CSCI 1300: Intro to Programming","Day":"M,Th,F","Time":"1:00 PM - 2:00 PM","Location":"HUMN 102"}]
');
		course("CSCI");
	}

	public function testName()
	{
		//Tests the name search function of to_json in much the same 
		//manner as above
		$this->expectOutputString('[{"Name":"Firstname Lastname","Classname":"PHYS 3220: Quantum Mechanics","Day":"M,T,W","Time":"3:00 PM - 4:00 PM","Location":"PHYS 200"}]
');
		name("Firstname Lastname");
	}
	
	public function testCourseNotExist()
	{
		//Tests the course function to ensure that, if passed a value 
		//that doesn't show up in the sql, it will properly return
		//an empty set.
		$this->expectOutputString('[]
');
		course("JPNS");
	}
}
?>
