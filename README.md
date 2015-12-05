# SoftwareEngineering3308
##TA/LA tracker
###By Frederik Lohner, Austin Holler, Tristian Hill and Marvin Tann

<p align="center">
  <img height="300" width="250" src="images/buffs.jpg" />
</p>

This project seeks to make it easier for students to look up when Teaching and Learning Assistants for their course have their Office/Help hours.

Repo Organization/Documentation location: The main directory of the repo contains test files, the PDF submissions for the assignments, our SQL file and several other files kept there for reference (For instance, a file containing example SQL queries that was used while developing the PHP files). 

The Openshift-App folder contains the PHP files used to extract data from our MySQL server to a JSON output (to_json.php), as well as the results of running doxygen on to_json. Note that  To_JSONDoxygen.pdf contains the output of our documentation in PDF format. 

The iOS/TALATracker folder contains all of the code and files used for the mobile application/iphone version of our project. 

The images folder contains a variety of vector images, to be used in our final presentation as well as potentially in our application itself.

Finally, the text-to-table-input-test contains the code for an early attempt to interface with our MySQL server, which we have kept around for the sake of potential future reference.

How to build/run/test code: Because our project is spread out over several languages and a hosting service, it is difficult to build in a concise manner. The file TADatabase.sql contains our SQL's structure, and sending that file into MySQL provides test data as well that can be used with out unit tests (contained in to_json_test.php). to_json, another major component of our project, does not require building and again can be tested in the same manner as above. 

(Austin-if you could describe the hosting service thing here, that'd be great--seems you're the one with the best handle on it, and it's pretty vital for getting an image of our project as a whole.) 


