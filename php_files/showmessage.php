<?php
$servername = "localhost";
$username ="root";
$password = "";
$dbname = "chat";
// Create connection
$con = mysqli_connect($servername, $username, $password, $dbname);
$dep = '';
$level='';
if(isset($_POST['dep'])){
    $dep= $_POST['dep'];
}
if(isset($_POST['level'])){
    $level = $_POST['level'];
}
$messages = array();
$result= mysqli_query($con,"select * from messages where (`dep`='$dep' and `level`='$level') OR (`dep`='$dep' and `level`='all')");
while ($row = mysqli_fetch_assoc($result)) {
    $messages[] = $row;
}
$response = array('messages' => $messages);
echo json_encode($messages)

?>