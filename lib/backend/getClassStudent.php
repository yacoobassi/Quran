<?php
include("connect.php");
include("secureFunction.php");

$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');
$group = filter('group');
$date = filter('date');

$stmt = $con->prepare("SELECT s.num, s.name,
    GROUP_CONCAT(DISTINCT CONCAT('{\"date\":\"', cs.date, '\",', 
        '\"study\":', cs.studyMark, ',',
        '\"exist\":', cs.exist, ',',
        '\"review\":', cs.reviewMark, ',',
        '\"tajoeed\":\"', cs.tajoeed, '\"}'
    ) ORDER BY cs.date ASC SEPARATOR ',') AS grades,
    AVG(CASE WHEN MONTH(cs.date) = MONTH(?) AND YEAR(cs.date) = YEAR(?) THEN cs.reviewMark END) AS reviewAvarege,
    AVG(CASE WHEN MONTH(cs.date) = MONTH(?) AND YEAR(cs.date) = YEAR(?) THEN cs.studyMark END) AS studyAvarege,
    SUM(cs.exist = 1) AS notcome,
    ra.act, ra.sala, ra.notes
    FROM classstudents cs
    JOIN student s ON s.num = cs.studentNum
    LEFT JOIN reportavarege ra ON ra.student = s.num AND DATE_FORMAT(ra.date, '%Y-%m') = DATE_FORMAT(cs.date, '%Y-%m')
    WHERE cs.`group` = ? AND cs.`instituteNum`= ? AND cs.`regimentNum`= ? 
    AND YEAR(cs.`date`) = YEAR(?) AND MONTH(cs.`date`) = MONTH(?)
    GROUP BY s.num, s.name
");


$stmt->execute(array($date, $date, $date, $date, $group, $instituteNum, $reginmentNum, $date, $date));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Decode the grades JSON string into an array
foreach ($data as &$row) {
    $row['grades'] = json_decode('[' . $row['grades'] . ']', true);
    if (is_numeric($row['reviewAvarege'])) {
        $row['reviewAvarege'] = number_format($row['reviewAvarege'], 2);
    }
    if (is_numeric($row['studyAvarege'])) {
        $row['studyAvarege'] = number_format($row['studyAvarege'], 2);
    }
}

$count = $stmt->rowCount();

echo json_encode(array("status" => "success", "count" => $count, "data" => $data));
