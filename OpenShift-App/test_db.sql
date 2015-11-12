CREATE TABLE IF NOT EXISTS `TAs` ( 
`ID` int(1) NOT NULL auto_increment, 
`Name` varchar(40) NOT NULL, 
PRIMARY KEY (`ID`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ; 

INSERT INTO `TAs` (`Name`) VALUES 
('Firstname Lastname'), 
('Firstname2 Lastname2'), 
('Firstname3 Lastname3'), 
('Firstname4 Lastname4');

CREATE TABLE IF NOT EXISTS `Classes` ( 
`ID` int(1) NOT NULL auto_increment,
`Classname` varchar(40) NOT NULL,
PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1; 

INSERT INTO `Classes` (`Classname`) VALUES 
('CSCI 3308: Methods + Tools'), 
('CSCI 3753: Operating Systems'), 
('CSCI 2400: Computer Systems'), 
('CSCI 1300: Intro to Programming'),
('PHYS 3220: Quantum Mechanics');

CREATE TABLE IF NOT EXISTS `Sessions` (
`ID` int(1) NOT NULL auto_increment,
`TAID` int(1) NOT NULL,
`ClassID` int(1) NOT NULL,
`Day` varchar(2) NOT NULL,
`Time` varchar(100) NOT NULL,
`Location` varchar(100) NOT NULL,
PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

INSERT INTO `Sessions`(`TAID`, `ClassID`, `Day`, `Time`, `Location`) VALUES
(3, 2, 'M,W,F', '10:30 AM - 3:00 PM', 'ECCS 200'),
(3, 1, 'Tu,Th,F', '2:00 PM - 5:00 PM', 'ECCS 200'),
(2, 3, 'W,Th,F', '10:00 AM - 1:30 PM', 'ECCR 123'),
(1, 5, 'M,T,W', '3:00 PM - 4:00 PM', 'PHYS 200'),
(4, 4, 'M,Th,F', '1:00 PM - 2:00 PM', 'HUMN 102');
