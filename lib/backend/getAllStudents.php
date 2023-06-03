<?php
include("connect.php");
include("secureFunction.php");

$institute = filter('institute');
$regiment = filter('regiment');

$stmt = $con->prepare("SELECT s.name, sd.*, COALESCE(ROUND(AVG(m.mark) * 10, 2), 'لم يحدد') AS mark
                       FROM student s
                       LEFT JOIN studentsdata sd ON s.num = sd.num
                       LEFT JOIN marks m ON s.num = m.studentNum
                       WHERE s.instituteNum = ? AND s.reginmentNum = ?
                       GROUP BY s.num");
$stmt->execute(array($institute, $regiment));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
echo json_encode(array("status" => "success", "count" => $count, "data" => $data));
?>
