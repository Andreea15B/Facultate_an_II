<!DOCTYPE html>
<html>
    <head>
        <title>Imagini</title>
        <style>
            body {text-align: center}
        </style>
    </head>
<?php
    define ('EXTENSIE', 'jpg'); // constant
    $extensie = EXTENSIE;
    $images = glob("./*.". $extensie); // Find pathnames matching a pattern
?>

    <body>
        <?php
        echo ('<ol>');
            foreach($images as $image) {
                echo $image;
            }
            echo ('</ol>');
            ?>
    </body>
</html>
