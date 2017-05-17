#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
use Path::Tiny;
use autodie;

my $dir = path("./");

my $file = $dir->child("pendrive_filesystem.dump");

sub blob {
    return $file->openr_utf8();
}

sub search {
    my $pattern = $_[0];
    my $content = blob();
    while( my $line = $content->getline() ) {
       $line =~ /$pattern/ and print $line;
    }
}

my $pattern;
GetOptions('search=s' => \$pattern) or die "Usage: $0 --search PATTERN\n";
if($pattern) {
    search($pattern)
}