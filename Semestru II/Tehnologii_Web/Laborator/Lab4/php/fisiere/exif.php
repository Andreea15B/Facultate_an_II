<?php
/* Program PHP care preia o imagine trimisa de client prin upload
   si genereaza un fisier text continand meta-datele incluse in aceasta
   (exemplu bazat pe diverse fragmente de cod oferite de manualul PHP oficial).
   Se ilustreaza si maniera de generare de exceptii proprii.
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2014, 2015, 2017

   Ultima actualizare: 14 martie 2017
*/

// numele directorului cu imagini furnizat in mod portabil
// (e.g., './imagini/' sau '.\imagini\')
define ('IMGDIR', '.' . DIRECTORY_SEPARATOR . 'imagini' . DIRECTORY_SEPARATOR);

try {
	// cream mai intai directorul de stocare a imaginilor, daca nu exista
	if (!is_dir(IMGDIR)) {
		mkdir (IMGDIR);
	}
	
	// prevenim incercari de transferuri malitioase
	if (!isset($_FILES['img']['error']) ||
        is_array($_FILES['img']['error'])) {
        throw new RuntimeException ('Upload: parametri eronati.');
    }
    
    switch ($_FILES['img']['error']) {	// transferul e in regula?
        case UPLOAD_ERR_OK:
            break;
        case UPLOAD_ERR_NO_FILE:
            throw new RuntimeException ('Upload: fisier netrimis.');
        case UPLOAD_ERR_INI_SIZE:
        case UPLOAD_ERR_FORM_SIZE:
            throw new RuntimeException ('Upload: fisier prea mare.');
        default:
            throw new RuntimeException ('Upload: eroare necunoscuta.');
    }

    // nu acceptam decat fisiere de maxim 1 MB
	if ($_FILES['img']['size'] > 1024 * 1024) {
        throw new RuntimeException ('Upload: fisier prea mare.');
    }

    // verificam daca a fost trimisa intr-adevar o imagine
    // pe baza tipurilor MIME (Media Types)
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    if (FALSE === $ext = array_search ($finfo->file($_FILES['img']['tmp_name']),
        array ('jpg' => 'image/jpeg',
               'png' => 'image/png',
               'gif' => 'image/gif'), true)) {
        throw new RuntimeException ('Upload: format incorect.');
    }

    // mutam fisierul transferat in directorul cu imagini
    // (generam un nume unic pentru fiecare imagine via SHA1)
    // detalii la http://php.net/manual/en/function.hash.php
    $numeImg = sprintf('%s.%s', 
                    sha1_file($_FILES['img']['tmp_name']), $ext);
    if (!move_uploaded_file ($_FILES['img']['tmp_name'], IMGDIR . $numeImg)) {
        throw new RuntimeException ('Upload: eroare la salvare.');
    }

    // preluam datele EXIF
	$exif = exif_read_data(IMGDIR . $numeImg, 0, true);	
	if (FALSE === $exif) {				// nu exista date EXIF?
		throw new RuntimeException ('Nu exista date EXIF'); 
	}

    // generam continut ca text obisnuit, nu HTML
    header ('Content-Type: text/plain');
    // ...si precizam ca va fi trimis ca resursa atasata
    header ('Content-Disposition: attachment; filename="info-exif.txt"');

	// iteram prin toate sectiunile de meta-date asociate imaginii
	foreach ($exif as $info => $sectiune) {
		foreach ($sectiune as $nume => $val) {
			echo "$info.$nume:\t$val\n";
		}
	}
} catch (RuntimeException $e) {         // a survenit o exceptie :(
    echo $e->getMessage();
}
?>