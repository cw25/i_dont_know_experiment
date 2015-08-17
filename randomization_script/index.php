<?php

$rand = rand(100000000, 999999999);

if ($rand % 2) {
	// CONTROL
	// $url = "https://www.surveymonkey.com/s/DW83VDG";
	$url = "https://berkeley.qualtrics.com/SE/?SID=SV_ebAhqOHhVtQ4i3j";
}
else {
	$rand = rand(100000000, 999999999);
	if ($rand % 2) {
		// MODERATE TREATMENT
		// $url = "https://www.surveymonkey.com/r/YGRK3FL";
		$url = "https://berkeley.qualtrics.com/SE/?SID=SV_ab27TJl99DbuABL";
	}
	else {
		// STRONG TREATMENT
		// $url = "https://www.surveymonkey.com/r/YG7WJ5R";
		$url = "https://berkeley.qualtrics.com/SE/?SID=SV_eex4VY92KCPMbE9";
	}
}

header("Location: " . $url);

