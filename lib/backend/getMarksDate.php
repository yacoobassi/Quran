<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');

$stmt = $con->prepare("SELECT DISTINCT `date`
                       FROM `marks`
                       WHERE `reginmentNum` = ? AND `instituteNum` = ?
                       ORDER BY `date` DESC");
 
$stmt->execute(array($reginmentNum, $instituteNum));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(array("status" => "success", "data" => $data));
