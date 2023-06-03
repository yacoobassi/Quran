<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum = filter_input(INPUT_POST, 'instituteNum', FILTER_SANITIZE_STRING);
$regimentNum = filter_input(INPUT_POST, 'reginmentNum', FILTER_SANITIZE_STRING);

// Check if regimentNum is set before including it in query
if (!isset($regimentNum) || $regimentNum == "") {
    // Handle the error here
}

$groupValue = filter_input(INPUT_POST, 'group', FILTER_SANITIZE_STRING);
$date = date("Y-m-d", strtotime(filter_input(INPUT_POST, 'date', FILTER_SANITIZE_STRING)));
$snapshot = filter_input(INPUT_POST, 'snapshot');

$snapshotData = json_decode($snapshot, true);

foreach ($snapshotData['data'] as $student) {
    for ($i = 0; $i < count($student['grades']); $i++) {
        $dateDay = $student['grades'][$i]['date'];
        $studentNum = $student['num'];
        $study = $student['grades'][$i]['study'];
        $review = $student['grades'][$i]['review'];
        $tajoeed = $student['grades'][$i]['tajoeed'];
        $exist = $student['grades'][$i]['exist'];
        $sala = $student['sala'];
        $notes = $student['notes'];
        $act = $student['act'];

        $sql = "UPDATE classstudents SET studyMark = :study, reviewMark = :review, exist = :exist, tajoeed = :tajoeed WHERE instituteNum = :instituteNum AND regimentNum = :regimentNum AND `date` = :dateDay AND `group` = :groupValue AND studentNum = :studentNum";
        $stmt = $con->prepare($sql);
        $stmt->bindParam(':study', $study);
        $stmt->bindParam(':review', $review);
        $stmt->bindParam(':exist', $exist);
        $stmt->bindParam(':tajoeed', $tajoeed);
        $stmt->bindParam(':instituteNum', $instituteNum);
        $stmt->bindParam(':regimentNum', $regimentNum);
        $stmt->bindParam(':dateDay', $dateDay);
        $stmt->bindParam(':groupValue', $groupValue);
        $stmt->bindParam(':studentNum', $studentNum);
        $stmt->execute();

        $sql = "UPDATE reportavarege SET act = :act, notes = :notes, sala = :sala WHERE YEAR(`date`) = YEAR(:dateDay) AND MONTH(`date`) = MONTH(:dateDay)  AND student = :studentNum";
        $stmt = $con->prepare($sql);
        $stmt->bindParam(':act', $act);
        $stmt->bindParam(':notes', $notes);
        $stmt->bindParam(':sala', $sala);
        $stmt->bindParam(':dateDay', $dateDay);
        $stmt->bindParam(':studentNum', $studentNum);
        $stmt->execute();
    }
}
