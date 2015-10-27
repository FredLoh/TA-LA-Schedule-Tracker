--Some example queries for the database-as far as I can tell, it should be relatively easy to call up any given set of data from it, as well as to insert/delete sessions, classes or TAs selectively. Worth noting that we could surround user input with %'s (%input%) to allow users to, say, enter in just a single name, or a part of a class name, and so long as there was an item that contained the characters between the two %'s, it would show up.
--Prints out the name of the TA, name of the class, and the date/time/location of the class for each individual office hour session
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID;

--Prints out all TAing sessions for the class SCSI 3753
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and Classes.Classname like 'CSCI 3753';

--Prints out all TAing sessions for all classes ending in the code '3753'
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and Classes.Classname like '%3753';

--Prints out all TAing sessions in the CSCI department
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and Classes.Classname like 'CSCI%';

--Prints out all TAing sessions hosted by the TA 'firstname lastname' (Or, y'know, whoever)
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and TAs.name like 'Firstname Lastname';

--Prints out all TAing sessions in which the class or TA's name contains the characters 'name2' (Probably the technique we would use for a basic TA/class search, with 'name2' inserted as the user's input)
select TAs.Name, Classes.Classname, Sessions.Day, Sessions.Time, Sessions.Location 
from TAs, Classes, Sessions 
where TAs.ID = Sessions.TAID and Classes.ID = Sessions.ClassID and (TAs.name like '%name2%' or Classes.Classname like '%name2%');

--Inserts a new TAing session into the sessions table. Inserting a TA or class is done in the exact same manner, though it is worth noting that to insert a session the relevant class and TA must already exist. Presumably, one would check to see if they exist, insert them if they do not, and then query for their ID values in order to insert them into Sessions. A bit roundabout, but probably worth it for the sake of the deleting method below, which requires the three-table setup
insert into `Sessions` (`TAID`, `ClassID`, `Day`, `Time`, `Location`) values (1, 3, 'W', '9:00 AM - 11:00 AM', 'ECCR 100');

delete from Sessions
where TAID in (select ID from TAs where TAs.Name = 'Firstname3 Lastname3');
