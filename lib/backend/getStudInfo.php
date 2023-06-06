<?php
include("connect.php");
include("secureFunction.php");

$num = filter('num');
$instituteNum = filter('instituteNum');
$regimentNum = filter('reginmentNum');

// Get the last exam mark for the student with number $num
$stmt = $con->prepare("
    SELECT mark
    FROM marks
    WHERE studentNum = ?
    ORDER BY date DESC
    LIMIT 1
");
$stmt->execute([$num]);
$lastMark = $stmt->fetchColumn();

// Get the average of the marks for the student with number $num
$stmt = $con->prepare("
    SELECT ROUND(AVG(mark), 1) as mark
    FROM marks
    WHERE studentNum = ?
");
$stmt->execute([$num]);
$avgMark = $stmt->fetchColumn();

// Set mark to 0 if it is null or empty
if ($lastMark === null || $lastMark === ''|| $lastMark === false) {
    $lastMark = 0;
}

if ($avgMark === null || $avgMark === '') {
    $avgMark = 0;
}

// Get the student data and join with the "student" table to retrieve the password
$stmt = $con->prepare("
    SELECT sd.*, s.password, s.name, institutes.name as institute_name, 
    CASE WHEN sd.nextExam = '' THEN 'لم يحدد' ELSE sd.nextExam END as nextExam,
    CASE WHEN sd.finishedParts = '' THEN 'لا يوجد' ELSE sd.finishedParts END as finishedParts
    FROM `studentsdata` AS sd
    JOIN `student` AS s ON sd.num = s.num
    JOIN `institutes` ON institutes.num=? AND institutes.regimentNum=?
    WHERE sd.num = ?
");

$stmt->execute([$instituteNum, $regimentNum, $num]);
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$rowCount = $stmt->rowCount();

if ($rowCount == 1) {
    // Add lastMark and avgMark to the data array
    $data[0]['lastMark'] = $lastMark;
    $data[0]['mark'] = $avgMark;

    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
}
?>
