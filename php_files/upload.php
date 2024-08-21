<?php
// Check if a file was uploaded
if(isset($_FILES['excel_file'])) {
  $file = $_FILES['excel_file'];
  $file_name = $file['name'];
  $file_tmp = $file['tmp_name'];

  // Save the uploaded file
  $upload_dir = 'upload/';
  $uploaded_file = $upload_dir . basename($file_name);
  move_uploaded_file($file_tmp, $uploaded_file);
  // Process the Excel file
  require 'vendor/autoload.php';
  $reader = new Xlsx();
  $spreadsheet = $reader->load($uploaded_file);
  $worksheet = $spreadsheet->getActiveSheet();
  // Connect to the MySQL database
  $servername = "localhost";
  $username = "root";
  $password = "";
  $database = "chat";

  $conn = new mysqli($servername, $username, $password, $database);

  // Check connection
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  // Insert data from the Excel file into the MySQL database
  $sql = "INSERT INTO student (`code`,`fullname`,`dep`,`level`) VALUES (?, ?, ?,?)";
  $stmt = $conn->prepare($sql);

  foreach ($worksheet->getRowIterator(3) as $row) {
    $cellIterator = $row->getCellIterator();
    $cellIterator->setIterateOnlyExistingCells(false);
    $values = [];
    foreach ($cellIterator as $cell) {
      $values[] = $cell->getValue();
    }
    $stmt->bind_param("sss", $values[0], $values[1], $values[2],$values[3]);
    $stmt->execute();
  }

  $stmt->close();
  $conn->close();

  echo "File uploaded and data inserted into the database successfully.";
} else {
  echo "No file was uploaded.";
}
?>