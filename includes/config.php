<?php

define('DB_HOST', 'db');
define('DB_USER', 'root');
define('DB_PASS', 'root');
define('DB_NAME', 'leave_staff');

$conn = mysqli_connect('db', 'root', 'root', 'leave_staff');

// Establish database connection.
try {
    $dbh = new PDO(
        'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME,
        DB_USER,
        DB_PASS,
        [PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"]
    );
} catch (PDOException $e) {
    exit('Error: ' . $e->getMessage());
}

?>
