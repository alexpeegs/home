<?php

require_once '../includes/DbOperation.php';

/*$response = array();*/

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
	$db = new DbOperation();
    $response['clubs'] = $db->getAllClubMapData();
    }
echo json_encode($response);
?>