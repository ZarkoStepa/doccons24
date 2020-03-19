<html>
<!--
DO NOT REMOVE THIS FILE
it is needed to show the testresults
-->
<head>
<title>Automatic reports</title>
</head>
<body>
<h1>Automatic reports</h1>
<ul>
<?php
$reports = array_reverse(glob('*/report*.html')); 
#print_r($reports); 

function reportname($path) {
     #return substr(strrchr($path, "/"), 1);
     return basename($path); 
}

function get_testcase($path) {
   $xmlfile = glob(dirname($path) . '/*.xml'); 
   # $xml = simplexml_load_file($xmlfile[0]);
   # FIXME should get only the first 10 lines and get the testcase name, or do it in the preparation already... 
   if (file_exists($xmlfile[0])) {
	# FIXME Loeading whole xml is to slow 
   	#$xml = simplexml_load_file($xmlfile[0]);
   	#echo sizeof($xml); 
    	#print_r($xml);
    } else {
    	# exit('Failed to open test.xml.');
    }
   return $xml[0]; 
}

function get_more_info($path) {
    $info="Env: Test "; 
    if (strpos($path, 'dev') !== false) {
    	$info="Env: Dev "; 
    }
    if (strpos($path, 'failed') !== false) {
        $info .= "FAILED: "; 
    }
    return $info;  
}

# FIXME show which environment has failed
foreach($reports as $file) {
    $link = '<li>%s<a href="%s">%s</a></li>'; 
    #echo $files; 
    echo sprintf($link, get_more_info($file), $file, reportname($file)); 
    # FiXME echo get_testcase($file); 
    #echo sprintf($link, $files, reportname($files)); 
}
?>
</ul>
</body>
</html>
