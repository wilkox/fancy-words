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
	'OE' => 'plain',
	'AS' => 'plain',
	'F' => 'fancy',
	'L' => 'fancy',
	'LL' => 'fancy',
);

die unless open(DICT, "<dict/pgwht04.txt");
die unless open(OUT, ">dict/ety.csv");

my @word;
my $ety;
my $lang;
while (my $line = <DICT>) {
	if ($line =~ /<h1>(.+)<\/h1>/) {
		@word = split(/,/, $1);
	}		
	if ($line =~ /<ety>(.+)<\/ety>/) {
		$ety = $1;
		$ety =~ /\[([^\.]+)\./;
		$lang = $1;
		next unless exists $lang{$lang};
		foreach my $word (@word) {
			$word =~ s/[^a-zA-Z]//g;
			print OUT "$word,$lang,$fancy{$lang}\n";				
		}
	}
}

close OUT;
close DICT;
