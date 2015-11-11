/*
To use the txt files generated from this enter a command in mysql similar to the below
command
mysql> LOAD DATA LOCAL INFILE '/path/(w/e).txt' INTO TABLE (w/e);
The command might be different depending on the machine you are running
the additional line of
    -> LINES TERMINATED BY '\r\n'; (for Windows editors that uses r\n\ as a line terminator)
may be required or
    -> LINES TERMINATED BY '\r'; (for apple OS X machines)

This file can generate up to 3 text files
1) for input into the table TAs         TAs.txt
2) for input into the table Classname   Classname.txt
3) for input into the table Sessions    Sessions.txt

The program will ask the user what they would like to enter via choosing which
table they would like to enter data for. The program can accept multiple entries
and will ask if the user would like to continue entering more data, switch to a
different table, or exit.

once done, the program will exit and the text files will have finished being
created in the current directory as the files listed above and then can be
used to enter data into the tables en masse via the above prompts

+++++++++// To Do \\+++++++++
Finish Sessions
Fix Issues below
Make ID's
make tests

+++++++++// Known issues \\+++++++++
p) Each time the program runs the .txt files are completely overwritten...
s) Could do a check to see if the file already exists and if so just add to it

p) when switching from one table to another if you switch back to one you have already
input data for, it will overwrite the entire .txt file...
s) fixing the first problem should fix this one...

p) ID's...
s) I could assign ID's based off of a for loop counter? And for class ID's say for csci 1300
1300 would not work since there could be a math 1300 so maybe use different numbers altogether?
Or letters and numbers probably the whole thing... so csci1300 since c1300 may be confused with
other departments that begin with c like coen


*/

#include <iostream>
#include <string>
#include <fstream>
#include "stdlib.h"

using namespace std;


void TAs()
{
    string a;
    bool donea = false;
    string yna;
    ofstream myfile;
    myfile.open ("TAs.txt");
    cout << "What is the TA/LA's Name? (First Last) (1 at a time please) : " << endl;
    getline(cin, a);
    myfile << a;
    for ( int ia = 0; donea == false; ia++) {
        cout << "Would you like to enter more names? (y/n) : "
        << endl << "Input must be 'y' or 'n'";
        getline(cin, yna);
        if (yna == "y"){
            string aa;
            cout << "What is their Name? (First Last) : " << endl;
            getline(cin, aa);
            myfile << "\n" << aa;
            donea = false;
        }
        else if (yna == "n"){
            string nexta;
            bool finala = false;
            do {
                cout << "Would you like to choose a different Table to make data for? (y/n)" << endl;
                getline(cin, nexta);
                if (nexta == "y"){
                    donea = true;
                    finala = true;
                }
                else if (nexta == "n"){
                    myfile.close();
                    exit(0);
                }
                else {
                    cout << "Error : enter lower case 'y' or 'n'" << endl;
                }
            } while (finala == false);
        }
        else {
            cout << "Error : enter lower case 'y' or 'n'" << endl;
            donea = false;
        }
    }
    myfile.close();
}

void Classname()
{
    string b;
    bool doneb = false;
    string ynb;
    ofstream myfile;
    myfile.open ("Classname.txt");
    cout << "What is their Class Name? (please only enter 1 class at a time) : "
    << endl << "Also please format as (CSCI 3308: Methods + Tools)";
    getline(cin, b);
    myfile << b;
    for (int ib = 0; doneb == false; ib++) {
        cout << "Does this TA/LA assist any other classes? (y/n) : "
        << endl << "input must be 'y' or 'n' ";
        getline(cin, ynb);
        if (ynb == "y"){
            string bb;
            cout << "What is their Class Name? (please enter 1 class at a time) : " << endl;
            getline(cin, bb);
            myfile << "\n" << bb;
            doneb = false;
        }
        else if (ynb == "n"){
            string nextb;
            bool finalb = false;
            do {
                cout << "Would you like to choose a different Table to make data for? (y/n)" << endl;
                getline(cin, nextb);
                if (nextb == "y"){
                    doneb = true;
                    finalb = true;
                }
                else if (nextb == "n"){
                    myfile.close();
                    exit(0);
                }
                else {
                    cout << "Error : enter lower case 'y' or 'n'" << endl;
                }
            } while (finalb == false);
        }
        else {
            cout << "Error : enter lower case 'y' or 'n'" << endl;
            doneb = false;
        }
    }
    myfile.close();
}

// Still need to finish this
void Sessions()
{
    //int c;
}

int main()
{
    string m;
    bool donem;
    string ynm;
    for (int im = 0; donem == false; im++) {
        cout << "What would you like to do? (1/2/3/4)" << endl
        << "(1) Enter data into TAs Table" << endl
        << "(2) Enter data into Classname Table" << endl
        << "(3) Enter data into Sessions Table" << endl
        << "(4) Exit the Program" << endl;
        getline(cin, m);
        if (m == "1"){
            TAs();
        }
        else if (m == "2"){
            Classname();
        }
        else if (m == "3"){
            Sessions();
        }
        else if (m == "4"){
            donem = true;
        }
        else {
            cout << "Incorrect input please enter the integers '1', '2', '3', or '4' only" << endl;
            donem = false;
        }
    }


    return 0;
}
