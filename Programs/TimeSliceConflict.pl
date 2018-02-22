use Data::Dumper;
open(out, ">Stats");
#11
@array_angio = ("40","41","42","43","44","45","46","47","48","49","50","30");
%Angio_hash = map {$_ => 1} @array_angio;
$angio = 0;
#9
@array_SO = ("31","32","33","34","35","36","37","38","39");
%SO_hash = map {$_ => 1} @array_SO;
$sup_order = 0;
#10
@array_Order = ("18","19","22","23","24","25","26","27","28","29");
%Order_hash = map {$_ => 1} @array_Order; 
$order = 0;
#7
@array_Family = ("14","15","16","17","4","20","21");
%Family_hash = map {$_ => 1} @array_Family;
$family = 0;
#12
@array_Genus = ("1","2","3","5","6","7","8","9","10","11","12","13");
%Genus_hash = map {$_ => 1} @array_Genus;

system("mkdir temp");
open(file, $ARGV[0])||die "No file\n";
while($line = <file>){

	$sup_order = 0;
	$order = 0;
	$family = 0;
	$angio = 0;
	$genus = 0;
	$total = 0;
	chomp $line;
	$name = ($line =~ m/.*?\/(.*)/)[0];
	print "$name\n";
	system("cp $line temp/");
	system("java -jar ../../../../phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -d temp/ -m TrueTree.tre -v");
	system("ls out.concord* > hold.txt");
	open(new, "hold.txt")||die "No concordant";
	while($file = <new>){
	
		chomp $file;
		$hit = ($file =~ m/concord.node.(.*)/)[0];
		if(exists $Angio_hash{$hit}){
			$angio += 1;
			$total++;
		}
		if(exists $SO_hash{$hit}){
			$sup_order += 1;
			$total++;
		}
		if(exists $Order_hash{$hit}){
			$order += 1;
			$total++;
		}
		if(exists $Family_hash{$hit}){
			$family += 1;
			$total++;
		}
		if(exists $Genus_hash{$hit}){
			$genus += 1;
			$total++;
		}
		
	}
	system("pxrmt -t temp/$name -n OG_Ginkgo_biloba,OG_Podocarpus_lambertii > temp.tre");
	system("pxlstr -t temp.tre > Tree");
	system("rm temp.tre");
	open(another,"Tree")||die "file\n";
	while($tree_line = <another>){
	
		chomp $tree_line;
		if($tree_line =~ /rttipvar/){
			$var = ($tree_line =~ m/.*?: (.*)/)[0];
		}elsif($tree_line =~ /treelength/){
			$len = ($tree_line =~ m/treelength: (.*)/)[0];
		}
		
	}
	
	print out "$line\t$angio\t$sup_order\t$order\t$family\t$genus\t$total\t$len\t$var\n";
	system("rm out* hold.txt");
	system("rm temp/*");
}
