<?php

/**
Code based on that found at 
https://www.simplifiedios.net/ios-registration-form-example/
**/

require_once '../includes/DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if (!verifyRequiredParams(array('username', 'password', 'fname', 'lname', 'email', 'phone'))) {
		//get values
		$username = $_POST['username'];
		$password = $_POST['password'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$email = $_POST['email'];
		$phone = $_POST['phone'];
		
		//db operation object
		$db = new DbOperation();
		
		//add user to database
		$result = $db->createUser($fname, $lname, $username, $password, $email, $phone);
		
		//respond according to whether the user exists or not
		if ($result == USER_CREATED) {
			$response['error'] = false;
			$response['message'] = 'User created successfully';
		} elseif ($result == USER_ALREADY_EXIST) {
			$response['error'] = true;
			$response['message'] = 'User already exists';
		} elseif ($result == USER_NOT_CREATED) {
			$response['error'] = true;
			$response['message'] = 'An error occured. User not created.';
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