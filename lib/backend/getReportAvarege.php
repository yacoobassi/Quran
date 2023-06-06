<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');

$stmt = $con->prepare("SELECT 
CASE 
    WHEN AVG(CASE tajoeed WHEN 'ممتاز' THEN 5 WHEN 'جيد جدا' THEN 4 WHEN 'جيد' THEN 3 WHEN 'متوسط' THEN 2 WHEN 'ضعيف' THEN 1 ELSE 0 END) >= 4.5 THEN 'ممتاز' 
    WHEN AVG(CASE tajoeed WHEN 'ممتاز' THEN 5 WHEN 'جيد جدا' THEN 4 WHEN 'جيد' THEN 3 WHEN 'متوسط' THEN 2 WHEN 'ضعيف' THEN 1 ELSE 0 END) >= 3.5 THEN 'جيد جدا' 
    WHEN AVG(CASE tajoeed WHEN 'ممتاز' THEN 5 WHEN 'جيد جدا' THEN 4 WHEN 'جيد' THEN 3 WHEN 'متوسط' THEN 2 WHEN 'ضعيف' THEN 1 ELSE 0 END) >= 2.5 THEN 'جيد' 
    WHEN AVG(CASE tajoeed WHEN 'ممتاز' THEN 5 WHEN 'جيد جدا' THEN 4 WHEN 'جيد' THEN 3 WHEN 'متوسط' THEN 2 WHEN 'ضعيف' THEN 1 ELSE 0 END) >= 1.5 THEN 'متوسط' 
    ELSE 'ضعيف' 
END AS tajoeed_avg,

AVG(studyMark) AS study_avg,
AVG(reviewMark) AS review_avg
FROM classstudents
WHERE instituteNum = ? And  regimentNum = ? And  YEAR(date) = YEAR(CURRENT_DATE()) AND MONTH(date) = MONTH(CURRENT_DATE());

");
$stmt->execute(array($instituteNum, $reginmentNum));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(array("status" => "success", "data" => $data));
