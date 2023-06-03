<?php

include('connect.php');
$stmt = $con->prepare("INSERT INTO `students`(`num`, `name`, `password`, `group`) VALUES ('444','Ali','4564','1')");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);


echo json_encode( $result);



