$name = $ARGV[0];
$Aname = ($name =~ /(.*?)\..*/)[0];
open(out1, ">$name\_1");
open(out2, ">$name\_2");
open(out3, ">$name\_3");

while($line = <>){

	chomp $line;
        if($line =~ />/){
                print out1 "$line\n";
		print out2 "$line\n";
		print out3 "$line\n";
        }else{
                @array = split "", $line;
                $numb = $#array / 3;
                $k = 0; $j = 1; $m = 2;$first = "";
		$second = ""; $third = "";
                foreach $i (0..$numb){
                        
                        $first .= $array[$k];
			$second .= $array[$j];
			$third .= $array[$m];
                        $k += 3;
			$m += 3;
			$j += 3;

                }
                print out1 "$first\n";
		print out2 "$second\n";
		print out3 "$third\n";

        }
}

open(out, ">$name\_sat.R");

print out "library(ape)\n";
print out "pdf(file= \"/home/jfwalker/Desktop/ConflictAndChloroplasts/FSAruns/SaturationAnalysis/$Aname.pdf\")\n";
print out "par(mfrow=c(2,2))\n";

print out "setwd(\"/home/jfwalker/Desktop/ConflictAndChloroplasts/FSAruns/SaturationAnalysis/\")\n";
print out "dat<-read.dna(file=\"$name\", format = \"fasta\", as.character=TRUE, skip=0)\n";
print out "dat<-as.DNAbin(dat)\n";
print out "dist<-dist.dna(dat, model=\"raw\")\n";
print out "dist.corrected<-dist.dna(dat, model=\"JC69\")\n";
print out "plot(dist~dist.corrected, pch=20, col=\"red\", xlab=\"JC69 model distance\", ylab=\"Uncorrected genetic distance\", main=\"$Aname Saturation (All Bases)\")\n";
print out "abline(0,1, lty=2)\n";
print out "abline(lm(dist~dist.corrected), lwd=3)\n";
print out "lm_coef<-coef(lm(dist~dist.corrected))\n";
print out "#text(0.1,0.05,bquote(y == .(lm_coef[2])*x))\n";

print out "dat<-read.dna(file=\"$name\_1\", format = \"fasta\", as.character=TRUE, skip=0)\n";
print out "dat<-as.DNAbin(dat)\n";
print out "dist<-dist.dna(dat, model=\"raw\")\n";
print out "dist.corrected<-dist.dna(dat, model=\"JC69\")\n";
print out "plot(dist~dist.corrected, pch=20, col=\"purple\", xlab=\"JC69 model distance\", ylab=\"Uncorrected genetic distance\", main=\"$Aname Saturation (1st Pos)\")\n";
print out "abline(0,1, lty=2)\n";
print out "abline(lm(dist~dist.corrected), lwd=3)\n";
print out "lm_coef<-coef(lm(dist~dist.corrected))\n";
print out "#text(0.1,0.05,bquote(y == .(lm_coef[2])*x))\n";

print out "dat<-read.dna(file=\"$name\_2\", format = \"fasta\", as.character=TRUE, skip=0)\n";
print out "dat<-as.DNAbin(dat)\n";
print out "dist<-dist.dna(dat, model=\"raw\")\n";
print out "dist.corrected<-dist.dna(dat, model=\"JC69\")\n";
print out "plot(dist~dist.corrected, pch=20, col=\"blue\", xlab=\"JC69 model distance\", ylab=\"Uncorrected genetic distance\", main=\"$Aname Saturation (2nd Pos)\")\n";
print out "abline(0,1, lty=2)\n";
print out "abline(lm(dist~dist.corrected), lwd=3)\n";
print out "lm_coef<-coef(lm(dist~dist.corrected))\n";
print out "#text(0.1,0.05,bquote(y == .(lm_coef[2])*x))\n";

print out "dat<-read.dna(file=\"$name\_3\", format = \"fasta\", as.character=TRUE, skip=0)\n";
print out "dat<-as.DNAbin(dat)\n";
print out "dist<-dist.dna(dat, model=\"raw\")\n";
print out "dist.corrected<-dist.dna(dat, model=\"JC69\")\n";
print out "plot(dist~dist.corrected, pch=20, col=\"green\", xlab=\"JC69 model distance\", ylab=\"Uncorrected genetic distance\", main=\"$Aname Saturation (3rd Pos)\")\n";
print out "abline(0,1, lty=2)\n";
print out "abline(lm(dist~dist.corrected), lwd=3)\n";
print out "lm_coef<-coef(lm(dist~dist.corrected))\n";
print out "#text(0.1,0.05,bquote(y == .(lm_coef[2])*x))\n";

print out "dev.off()\n";

system("Rscript $name\_sat.R");
system("rm $name\_1 $name\_2 $name\_3 $name\_sat.R");
