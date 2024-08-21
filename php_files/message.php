
<?php
// MySQL database credentials

$servername = "localhost";
$username ="root";
$password = "";
$dbname = "chat";
// Create connection
$con = mysqli_connect($servername, $username, $password, $dbname);

$level = '';
$message = '';
$time = '';
if(isset($_POST['level'])){
 $level =$_POST['level'];
}

if(isset($_POST['message'])){
    $message =$_POST['message'];
}
$dep='';
if(isset($_POST['dep'])){
    $dep =$_POST['dep'];
}
if(isset($_POST['time'])){
    $time =$_POST['time'];
   }

// Insert data into the database

    $query = "INSERT INTO messages(`mess`,`dep`,`level`,`times`) VALUES ('$message','$dep','$level','$time')";
    $results = mysqli_query($con,$query);
    if($results>0)
    {
        echo "user added successfully";
    }
?>