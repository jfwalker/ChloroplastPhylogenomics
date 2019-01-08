#Get alignment length
$name = $ARGV[0];
$p_name = ($name =~ m/(.*?)\..*/)[0];
system("pxlssq -s $name | grep \"Seq\" > temp.txt");
open(name, "temp.txt")||die "No temp\n";
while($line = <name>){
	
	@array = split " ", $line;
	print "$p_name\t$array[2]\n";

}

system("rm phyx.logfile temp.txt");
