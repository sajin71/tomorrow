<table border="1">
<tr><th>test</th><th>ans</th><th>compile</th><th>asm</th><th>simu</th><th>diff</th></tr>

<?php

$tests = array( "print", "sum-tail", "gcd", "sum", "fib", "ack", "even-odd", "adder", "funcomp", "cls-rec", "cls-bug", "cls-bug2", "shuffle", "spill", "spill2", "spill3", "join-stack", "join-stack2", "join-stack3", "join-reg", "join-reg2", "non-tail-if", "non-tail-if2", "inprod", "inprod-rec", "inprod-loop", "matmul", "matmul-flat");

$gitroot = '../../';
$testdir = $gitroot . 'compiler/test/';

$testall = 0;
$testok = 0;

foreach ( $tests as $t ) {
	
	$testall++;
	
	$remain = 5;
	
	echo "<tr><td>$t</td>";
	
	
	$remain--;
	system("ocaml {$testdir}{$t}.ml > {$testdir}{$t}.ans", $ret);
	if ( $ret != 0 ) {
		fail($remain);
		continue;
	}
	succ();
	
	$remain--;
	system(" {$gitroot}compiler/min-caml {$testdir}$t", $ret);
	if ( $ret != 0 ) {
		fail($remain);
		continue;
	}
	succ();
		
	$remain--;
	system("{$gitroot}asm/asm {$testdir}{$t}.s  {$testdir}{$t}.bin", $ret);
	if ( $ret != 0 ) {
		fail($remain);
		continue;
	}
	succ();
	
	$remain--;
	system("{$gitroot}convx86/testsimu < {$testdir}{$t}.bin > {$testdir}{$t}.res", $ret);
	if ( $ret != 0 ) {
		fail($remain);
		continue;
	}
	succ();
	
	$remain--;
	system("diff {$testdir}{$t}.res {$testdir}{$t}.ans > {$testdir}{$t}.cmp", $ret);
	if ( $ret != 0 ) {
		fail($remain);
		continue;
	}
	succ();
	
	$testok++;
	echo "</tr>\n";
}

echo "\n</table>\n\n<p>Test Succeeded: {$testok}/{$testall}</p>\n";

function succ() {
	echo '<td bgcolor="	#33ff33">OK</td>';
}

function fail($remain) {
	echo '<td bgcolor="#ff99ff">FAIL</td>';
	for($i=0; $i < $remain; $i++) {
		echo '<td>-</td>';
	}
	echo "</tr>\n";
}