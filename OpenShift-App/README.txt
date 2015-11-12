OpenShift is a Platform-as-a-Service that we're using for this project.
OpenShift makes our lives easier by allowing us to host and access our content easily online.

Since we're using a free version (i.e. No team sharing) the username/password can be found
online on our project tracking tool.

USING OPENSHIFT:

- In order to use OpenShift to its full potential you have to follow the setup at 
  https://developers.openshift.com/en/getting-started-overview.html
- Select your operating system your using and follow the instructions
- Once you're finished with this you can manipulate/create/etc (read more on OpenShift) 
  the project locally and change it with git
- To clone a project, go to the project and use git clone with the ssh link under soure code

* I've set this up on Debian/Ubuntu (the VM) and there are a few hiccups:
	- You don't need to install rubygems because it should come by default with 
	  ruby-full
	- Step 3 is not "sudo gem install rhc" because the RHC path won't get installed 
	  properly
	- Step 3 is "rvmsudo gem install rhc"
		- If you don't have rvm follow install instructions at: https://rvm.io/rvm/install
			- "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
			- "\curl -sSL https://get.rvm.io | bash"
				- If you don't have curl: "sudo apt-get install curl"

PROJECT:

- From what I've figured out, index.php is going to be the file that the app looks for.
  So it's what we'll want to manipulate for the user end. to_json.php is the back end
  "working" file that gets called in index.php.

- I haven't added functionality for "AddSession" because we'll have to come up with
  a good way to do multiple fields. If you look at all of the other searches, adds,
  and deletes you'll notice they all take one argument. Currently that's how I have
  the posts set up to handle inputs, but there's probably a better way of doing this;
  I just haven't figured it out yet.

- test_db.sql is just the file for the database for reference. It's not the literal database
  that OpenShift is using. They host the database/.sql on their servers and it's not something
  we have access to directly, but we can manipulate it.

- Otherwise the database, php, and json is up and ready for use. Check it out for yourself!


Link to running app: http://myfirstphpapp-testingtojson1.rhcloud.com/
