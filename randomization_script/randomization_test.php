<?php

function gen_rand() {
$rand = rand(100000000, 999999999);

if ($rand % 2) {
	$url = "CONTROL";
}
else {
	$rand = rand(100000000, 999999999);
	if ($rand % 2) {
		$url = "MODERATE";
	}
	else {
		$url = "STRONG";
	}
}
return $url;
}

while(TRUE) {
	echo gen_rand() . "\n";
}
