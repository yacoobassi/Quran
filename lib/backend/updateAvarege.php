<?php 

include("connect.php");
include("secureFunction.php");

$sala = filter('sala');
$notes = filter('notes');
$regimentNum = filter('regimentNum');
$instituteNum = filter('instituteNum');
$num = filter('num');
$date = filter('date');
$act = filter('act');

$stmt = $con->prepare("UPDATE `reportavarege` 
                        SET `sala` = $sala, 
                            `notes` = $notes, 
                            `student` = `student`,
                            `instituteNum` = `instituteNum`,
                            `regimentNum` = `regimentNum`,
                            `date` = `date`,
                            `act` = $act 
                        WHERE regimentNum = $regimentNum 
                          AND instituteNum = $instituteNum 
                          AND YEAR(`date`) = YEAR('$date')
                          AND MONTH(`date`) = MONTH('$date')");

$stmt->execute(array());

$rowCount = $stmt->rowCount();
if ($rowCount == 1) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
}
