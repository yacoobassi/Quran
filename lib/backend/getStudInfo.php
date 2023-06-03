<?php 

include("connect.php");
include("secureFunction.php");

$num = filter('num');
$instituteNum = filter('instituteNum');
$regimentNum = filter('regimentNum');

// get the last exam mark for the student with number $num
$stmt = $con->prepare("
    SELECT mark
    FROM marks
    WHERE studentNum = ?
    ORDER BY date DESC
    LIMIT 1
");
$stmt->execute([$num]);
$lastMark = $stmt->fetchColumn();

// get the average of the marks for the student with number $num
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

// get the student data
$stmt = $con->prepare("
    SELECT studentsdata.*, student.name, institutes.name as institute_name, 
    CASE WHEN studentsdata.nextExam = '' THEN 'لم يحدد' ELSE studentsdata.nextExam END as nextExam,
    CASE WHEN studentsdata.finishedParts = '' THEN 'لا يوجد' ELSE studentsdata.finishedParts END as finishedParts
    FROM `studentsdata`
    JOIN `student` ON studentsdata.num = student.num
    JOIN `institutes` ON institutes.num=? AND institutes.regimentNum=?
    WHERE studentsdata.num = ?
");

$stmt->execute([$instituteNum, $regimentNum, $num]);
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$rowCount = $stmt->rowCount();

if ($rowCount == 1) {
    // add lastMark and avgMark to the data array
    $data[0]['lastMark'] = $lastMark;
    $data[0]['mark'] = $avgMark;

    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
}