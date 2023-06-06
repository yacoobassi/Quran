<?php 

include("connect.php");
include("secureFunction.php");

$post = filter('post');

$stmt = $con->prepare("
    SELECT c.comment,c.image, c.date, COALESCE(t.name, s.name) AS name 
    FROM comments c
    LEFT JOIN teacherData t ON c.num = t.num
    LEFT JOIN student s ON c.num = s.num
    WHERE c.postNum = :post
    ORDER BY c.date DESC
");
$stmt->bindParam(':post', $post, PDO::PARAM_INT);
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode(array("status" => "success","data"=>$data));
