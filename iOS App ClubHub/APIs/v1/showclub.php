<?php

/**
Code based on that found at 
https://www.simplifiedios.net/xcode-login-screen-example/
**/

require_once '../includes/DbOperation.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$db = new DbOperation();
    $response['user'] = $db->ShowClub($_POST['clubid']);
    }

echo json_encode($response);
?>