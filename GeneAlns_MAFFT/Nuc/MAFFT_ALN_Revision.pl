system("mkdir MadeTrees/");
$count = 0;
$name = $ARGV[0];
$temp = ($name =~ m/(.*?)\..*/)[0];
$name = $temp;
#system.exit();
#system("mafft --auto --amino --maxiterate 1000 --thread 2 $name > $name.aln");
#system("~/phyx/src/pxclsq -s $name.aln -o $name.aln-cln -p 0.1 -a");
open(File, $ARGV[0])||die "How?";
while($line = <File>){

	if ($line =~ />/){

		$count++;	
	}
}
$arg = $ARGV[0];

	system("mafft --auto --amino --maxiterate 1000 --thread 3 $arg > $name.aln");
	#system("~/phyx/src/pxclsq -s $name.aln -o $name.aln-cln -p 0.1 -a");

	$name = "$name.aln";

	system("raxmlHPC -f a -# 200 -x 112233 -T 3 -p 12345 -m GTRGAMMA -s $name -n $name\.tre");
	system("rm RAxML_result* RAxML_parsimony* RAxML_log* RAxML_info*");
	system("mv RAxML_bestTree\.$name\.tre $name\.tre");
	system("mv $name $name\.tre $name\.aln $name\.aln-cln MadeTrees/");


	system("mv $name MadeTrees/");

	
