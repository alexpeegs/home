<?php

/**
Code based on that found at 
https://www.simplifiedios.net/ios-registration-form-example/
**/

class dbOperation
{
	private $conn;
	
	//Constructor
	function __construct()
	{
		require_once dirname(__FILE__) . '/Constants.php';
		require_once dirname(__FILE__) . '/DbConnect.php';
		//Open new db connection
		$db = new DbConnect();
		$this->conn = $db->connect();
	}
	
    /*
     * This method is added
     * We are taking username and password
     * and then verifying it from the database
     * */
    public function userLogin($username, $pass)
    {
    	$hash = $this->getPass($username);
    	if (password_verify($pass, $hash)) {
    	$stmt = $this->conn->prepare("SELECT userID FROM users WHERE username = ? AND userPass = ?");
        $stmt->bind_param("ss", $username, $hash);
        $stmt->execute();
        $stmt->store_result();
        }
        return $stmt->num_rows > 0;
    }
    
    public function getPass($username)
    {
        $stmt = $this->conn->prepare("SELECT userPass FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $stmt->bind_result($pass);
        $stmt->fetch();
        $hashedpass = $pass;
        return $hashedpass;
    }

    /*
     * After the successful login we will call this method
     * this method will return the user data in an array
     * */

    public function getUserByUsername($username)
    {
        $stmt = $this->conn->prepare("SELECT userID, username, email, phone, fname, lname FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $stmt->bind_result($id, $uname, $email, $phone, $fname, $lname);
        $stmt->fetch();
        $user = array();
        $user['userID'] = $id;
        $user['username'] = $uname;
        $user['email'] = $email;
        $user['phone'] = $phone;
        $user['fname'] = $fname;
        $user['lname'] = $lname;
        return $user;
    }
        /*
     * This method is added
     * We are getting all the club data needed to show on Map screen
     * */
    public function getAllClubMapData()
    {
        $stmt = $this->conn->prepare("SELECT clubID, clubName, clubCoordOne, clubCoordTwo, snippet FROM clubs WHERE clubCoordOne IS NOT NULL ORDER BY clubName ASC");
        $stmt->execute();
        $result = $stmt->get_result();
		if($result->num_rows === 0) exit('No rows');
		while($row = $result->fetch_object()) {
  		$arr[] = $row;
		}
		return $arr;

        
    }
        
     /* * get userID use it to find clubIDs
     select club info */
         public function UserClubs($userid)
    {
        $stmt = $this->conn->prepare("SELECT distinct c.clubID, c.clubName, c.clubEmail, c.description FROM users as u, clubs as c, userClubs as uc WHERE u.userID = ? AND u.userID = uc.userID AND uc.clubID = c.clubID AND uc.clubID = c.clubID");
        $stmt->bind_param("s", $userid);
        $stmt->execute();
        $result = $stmt->get_result();
		if($result->num_rows === 0) exit('No rows');
		while($row = $result->fetch_object()) {
  		$arr[] = $row;
		}
		return $arr;
    }
        public function ClubEvents($clubid)
    {
        $stmt = $this->conn->prepare("SELECT distinct CONCAT(u.fname,' ',u.lname) as name, ce.eventName, DATE_FORMAT(ce.eventDate, '%a %M %e %Y') as eventDate, TIME_FORMAT(ce.eventTime, '%r') as eventTime, ce.eventDesc, ce.eventCoordOne, ce.eventCoordTwo FROM users as u, clubEvents as ce WHERE ce.clubID = ? AND u.userID = ce.userID");
        $stmt->bind_param("s", $clubid);
        $stmt->execute();
        $result = $stmt->get_result();
		if($result->num_rows === 0) exit('No rows');
		while($row = $result->fetch_object()) {
  		$arr[] = $row;
		}
		return $arr;
    }
    
         public function ShowClub($clubid)
    {
        $stmt = $this->conn->prepare("SELECT clubID, clubName, clubEmail, description, snippet, clubAddress FROM clubs WHERE clubID = ?");
        $stmt->bind_param("s", $clubid);
        $stmt->execute();
        $stmt->bind_result($clubid, $clubname, $clubemail, $clubabout, $clubsnippet, $clubaddress);
        $stmt->fetch();
        $user = array();
        $user['clubid'] = $clubid;
        $user['clubname'] = $clubname;
        $user['clubemail'] = $clubemail;
        $user['clubabout'] = $clubabout;
        $user['clubsnippet'] = $clubsnippet;
        $user['clubaddress'] = $clubaddress;
        return $user;
    }


         public function joinClub($userid, $clubid)
	{
		if (!$this->isInClubExist($userid, $clubid)) {
			$stmt = $this->conn->prepare("INSERT INTO userClubs (userID, clubID) VALUES (?, ?)");
			$stmt->bind_param("ss", $userid, $clubid);
			if ($stmt->execute()) {
				return USER_CREATED;
			} else {
				return USER_NOT_CREATED;
			}
		} else {
			return USER_ALREADY_EXIST;
		}
	}

			private function isInClubExist($userid, $clubid)
	{
		$stmt = $this->conn->prepare("SELECT clubID FROM userClubs WHERE userID = ? AND clubID = ?");
		$stmt->bind_param("ss". $userid, $clubid);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}

     
 
     
             /*
     We are taking userid
     and then using it to update the user's data in table
     */
    public function updateUser($userid, $fname, $lname, $email, $phone)
    {
        $stmt = $this->conn->prepare("UPDATE users SET fname = ?, lname = ?, phone = ?, email = ? WHERE userID = ?");
        $stmt->bind_param("sssss", $fname, $lname, $phone, $email, $userid);
        if($stmt->execute()){
        return true;
        }
        else {
        return false;
        }

        
    }
	
	//Function to create new user
	public function createUser($fname, $lname, $username, $userpass, $email, $phone)
	{
		if (!$this->isUserExist($username, $email, $phone)) {
			$password = password_hash($userpass, PASSWORD_DEFAULT);
			$stmt = $this->conn->prepare("INSERT INTO users (fname, lname, username, userPass, email, phone) VALUES (?, ?, ?, ?, ?, ?)");
			$stmt->bind_param("ssssss", $fname, $lname, $username, $password, $email, $phone);
			if ($stmt->execute()) {
				return USER_CREATED;
			} else {
				return USER_NOT_CREATED;
			}
		} else {
			return USER_ALREADY_EXIST;
		}
	}
	
		public function createClub($clubname, $clubemail, $clubpass, $clubabout, $clubaddress, $clublat, $clublong, $clubloc)
	{
		if (!$this->isClubExist($clubname, $clubemail)) {
			$stmt = $this->conn->prepare("INSERT INTO clubs (clubName, clubEmail, clubPass, description, clubAddress, clubCoordOne, clubCoordTwo, snippet) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			$stmt->bind_param("ssssssss", $clubname, $clubemail, $clubpass, $clubabout, $clubaddress, $clublat, $clublong, $clubloc);
			if ($stmt->execute()) {
				return USER_CREATED;
			} else {
				return USER_NOT_CREATED;
			}
		} else {
			return USER_ALREADY_EXIST;
		}
	}
	///clubName, clubEmail, clubPass, clubCoordOne, clubCoordTwo, snippet, description
		private function isClubExist($clubname, $clubemail)
	{
		$stmt = $this->conn->prepare("SELECT clubID FROM clubs WHERE clubName = ? OR clubEmail = ?");
		$stmt->bind_param("ss". $clubname, $clubemail);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}
	
	
		public function createEvent($userid, $clubid, $eventName, $eventCoordOne, $eventCoordTwo, $eventDesc, $eventDate, $eventTime)
	{
		if (!$this->isEventExist($eventName, $eventDate, $eventTime)) {
			$stmt = $this->conn->prepare("INSERT INTO clubEvents (userID, clubID, eventName, eventCoordOne, eventCoordTwo, eventDesc, eventDate, eventTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			$stmt->bind_param("ssssssss", $userid, $clubid, $eventName, $eventCoordOne, $eventCoordTwo, $eventDesc, $eventDate, $eventTime);
			if ($stmt->execute()) {
				return USER_CREATED;
			} else {
				return USER_NOT_CREATED;
			}
		} else {
			return USER_ALREADY_EXIST;
		}
	}
	///clubName, clubEmail, clubPass, clubCoordOne, clubCoordTwo, snippet, description
		private function isEventExist($eventName, $eventDate, $eventTime)
	{
		$stmt = $this->conn->prepare("SELECT eventID FROM clubEvents WHERE eventName = ? AND eventDate = ? AND eventTime = ?");
		$stmt->bind_param("sss". $eventName, $eventDate, $eventTime);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}
	
	private function isUserExist($username, $email, $phone)
	{
		$stmt = $this->conn->prepare("SELECT userID FROM users WHERE username = ? OR email = ? OR phone = ?");
		$stmt->bind_param("sss". $username, $email, $phone);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}
	
	public function getClubTags()
	{
		$stmt = $this->conn->prepare("SELECT tagID, tag FROM tags ORDER BY tag ASC");
        $stmt->execute();
        $result = $stmt->get_result();
		if($result->num_rows === 0) exit('No rows');
		while($row = $result->fetch_object()) {
  		$arr[] = $row;
		}
		return $arr;
		}
}
?>
		