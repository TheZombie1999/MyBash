
UNI=~/OneDrive/Universitaet
UNI6=$UNI/6.Semester

PHYSIK2=$UNI/6.Semester/Physik2
ALGGEO=$UNI/6.Semester/AlgorithmischeGeometrie
HCI=$UNI/6.Semester/HumanComputerInteraction

pVar () {
	echo UNI
	echo UNI6
	echo PHYSIK2
	echo ALGGEO
	echo HCI
}

TEMPLATES=~/OneDrive/Personal/Templates


newFromTemplate (){
	if [ $# -eq 0 ]; then 
		la $TEMPLATES
	elif [ $# -eq 1 ] ; then
		cp -r $TEMPLATES/$1 $(pwd)
	elif [ $# -eq 2 ]; then
		cp -r $TEMPLATES/$1 $(pwd)	
		mv $1 $2	
	else 
		echo Too Many Arguments
	fi
}

alias nft="newFromTemplate"

newFromTemplateAdd (){
	if [ $# -ne 1 ]; then	
		echo You can add one of these files
		la
	else
		cp $(pwd)/$1 $TEMPLATES
	fi 
}

pdfAppend () {
	if [ $# -ne 2 ]; then
		echo Error PdfAppend needs At least two Arguments
	else
		pdftk $1.pdf $2.pdf cat output $1.1.pdf
		rm $2.pdf
		mv $1.1.pdf $1.pdf
	fi
}

alias pdfa="pdfAppend"

alias nfta="newFromTemplateAdd"

alias mu="mupdf"

alias gs="git status -s"

alias sfm="safefastMerge"

alias dnt='dotnet test --logger:"console;verbosity=detailed"'


fastMerge() {
	for dir in $(ls -xd *)
	do
		cd $dir
		first=$(ls -xp | xargs | grep -v / | awk '{print $1;}')
		newfirst="${dir,,}.pdf"
		echo $first
		echo $newfirst
		mv -v "$first" "$newfirst"

		for file in $(ls -p | grep -v /)
		do
			if [ $file == $newfirst ]; then 
				continue	
			fi
			
			one=$(echo "$newfirst" | sed 's/.pdf//' )
			two=$(echo "$file" | sed 's/.pdf//' )
			echo $one
			echo $two
			pdfAppend $one $two
		done
		cd ..
	done
}


safefastMerge() {
	cur=$(pwd | awk -F/ '{print $NF}')
	cp -r ../$cur ../$cur-copy

	fastMerge
}



