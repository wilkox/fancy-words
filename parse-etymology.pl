#!/usr/bin/perl
use warnings;

#Parses the dictionary into a simple list of
# words of latin, french and german/old english
# origins

%lang = (
	'OE' => 'old english',
	'F' => 'french',
	'L' => 'latin',
	'LL' => 'late latin',
	'AS' => 'anglo-saxon',
);

%fancy = (
	'OE' => 'not fancy',
	'AS' => 'not fancy',
	'F' => 'fancy',
	'L' => 'fancy',
	'LL' => 'fancy',
);

die unless open(DICT, "<dict/pgwht04.txt");
die unless open(OUT, ">dict/ety.csv");

my $word;
my $ety;
my $lang;
while (my $line = <DICT>) {
	if ($line =~ /<h1>(.+)<\/h1>/) {
		$word = $1;
	}		
	if ($line =~ /<ety>(.+)<\/ety>/) {
		$ety = $1;
		$ety =~ /\[([^\.]+)\./;
#		print "\nlang is $1";
		next unless exists $lang{$1};
		print OUT "$word, $1\n";				
	}
}

close OUT;
close DICT;
