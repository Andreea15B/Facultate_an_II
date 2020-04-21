<!DOCTYPE html>
<html>
    <head>
        <title>Rezultat</title>
</head>
    <body>
        <?php 
            if($_REQUEST["alegere"] == 'caine') {
                $url = 'http://shibe.online/api/shibes?count=5&urls=true&httpsUrls=true';
                $ch = curl_init();

                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

                $output = curl_exec($ch);
                // echo $output;
                curl_close($ch);

                $results = json_decode($output);
                // echo $results;
                for($i=0; $i<5; $i++) {
                echo '<img src="' . $results[$i] . '"/>';
                }
            }
            else if($_REQUEST["alegere"] == 'pisica') {
                $url = 'https://aws.random.cat/meow';

                $ch = curl_init();

                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

                $output = curl_exec($ch);
                $curl_error = curl_error($ch);
                curl_close($ch);

                $results = json_decode($output);
                echo '<img src="' . $results->file . '"/>';
            }
            else echo '<p>Nu ai ales bine</p>';
            
        ?>
    </body>
</html>