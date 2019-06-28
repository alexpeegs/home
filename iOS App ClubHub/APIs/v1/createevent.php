<?php

/**
Code based on that found at 
https://www.simplifiedios.net/ios-registration-form-example/
**/

require_once '../includes/DbOperation.php';

$response = array();
            
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if (!verifyRequiredParams(array("userid", "clubid", "eventName", "eventCoordOne", "eventCoordTwo", "eventDesc","eventDate", "eventTime"))) {
		//get values
		$userid = $_POST['userid'];
		$clubid = $_POST['clubid'];
		$eventName = $_POST['eventName'];
		$eventCoordOne = $_POST['eventCoordOne'];
		$eventCoordTwo = $_POST['eventCoordTwo'];
		$eventDesc = $_POST['eventDesc'];
		$eventDate = $_POST['eventDate'];
		$eventTime = $_POST['eventTime'];
		
		//db operation object
		$db = new DbOperation();
		
		//add Club to database
		$result = $db->createEvent($userid, $clubid, $eventName, $eventCoordOne, $eventCoordTwo, $eventDesc, $eventDate, $eventTime);
		
		//respond according to whether the Club exists or not
		if ($result == USER_CREATED) {
			$response['error'] = false;
			$response['message'] = 'Event created successfully';
		} elseif ($result == USER_ALREADY_EXIST) {
			$response['error'] = true;
			$response['message'] = 'Event already exists';
		} elseif ($result == USER_NOT_CREATED) {
			$response['error'] = true;
			$response['message'] = 'An error occured. Event not created.';
		}
	} else {
		$response['error'] = true;
		$response['message'] = 'Required parameters are missing';
	}
} else {
	$response['error'] = true;
	$response['message'] = 'Invalid request';
}

//validate required parameters are present
function verifyRequiredParams($required_fields)
{

	//get request params
	$request_params = $_REQUEST;
	
	//Loop through all parameters
	foreach ($required_fields as $field) {
		//if any required parameter is missing
		if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
		
			//return true
			return true;
		}
	}
	//otherwise, return false
	return false;
}

echo json_encode($response);

?>