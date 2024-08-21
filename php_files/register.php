<?php


$servername = "localhost";
$username ="root";
$password = "";
$dbname = "chat";
// Create connection
$con = mysqli_connect($servername, $username, $password, $dbname);

$code = '';
$fullname='';
if(isset($_POST['code'])){
    $code= $_POST['code'];
}
if(isset($_POST['fullname'])){
    $fullname = $_POST['fullname'];
}

$dep = '';
$level='';
if(isset($_POST['dep'])){
    $dep= $_POST['dep'];
}
if(isset($_POST['level'])){
    $level = $_POST['level'];
}
$result= mysqli_query($con,"insert into student(`fullname`,`dep`,`level`,`code`) values ('$fullname','$dep','$level','$code')");
if ($result->num_rows > 0) {
    // Fetch user data and return as a JSON response
    $user = $result->fetch_assoc();
    echo json_encode($user);
} else {
    // Return an error message
    echo json_encode(array('error' => 'Invalid email or password'));
}
?>