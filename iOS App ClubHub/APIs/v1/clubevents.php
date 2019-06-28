<?php

/**
Code based on that found at 
https://www.simplifiedios.net/xcode-login-screen-example/
**/

require_once '../includes/DbOperation.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
	$db = new DbOperation();
    $response['clubs'] = $db->ClubEvents($_GET['clubid']);
    }

echo json_encode($response);
?>