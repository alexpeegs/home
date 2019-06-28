<?php

/**
Code based on that found at 
https://www.simplifiedios.net/ios-registration-form-example/
**/

require_once '../includes/DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if (!verifyRequiredParams(array('userID', 'fname', 'lname', 'email', 'phone'))) {
		//get values
		$userid = $_POST['userID'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$email = $_POST['email'];
		$phone = $_POST['phone'];
		
		//db operation object
		$db = new DbOperation();
		
		//add user to database
		$result = $db->updateUser($userid, $fname, $lname, $email, $phone);
		
		//respond according to whether the user exists or not
		if ($result == true) {
			$response['error'] = false;
			$response['message'] = 'User updated successfully';
			$user = array();
        	$user['email'] = $email;
        	$user['phone'] = $phone;
        	$user['fname'] = $fname;
        	$user['lname'] = $lname;
			$response['user'] = $user;
		
		} else {
			$response['error'] = true;
			$response['message'] = 'An error occured. User not updated.';
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