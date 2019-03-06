cd ${1-./}

# rename file to studentID.docx/.pdf
rename 's/^hw\d{6}_([a-z].{8}|es_\d{5})_[^_]*_(\d{1,2})/$1_$2/' *.pdf


#remove previous version from same person
for file in *.pdf;
do
	# filename get student ID
	# studentID=$(echo $file | sed -e 's/\..*//')
	studentID=$(echo $file | sed -e 's/_.\..*//')
	# tmp=$(echo $file | sed -e 's/\..*//')
	# version=$(echo $tmp | sed -e 's/.*\([0-9]$\)/\1/')
	filenumber=$(ls -dq *$studentID* | wc -l)
	
	#if there are more than two files from same person
	#remove previous version
	if [ $filenumber -ge 2 ]; then
		for ((i=1; i<$filenumber; i++));
		do
			rm echo $studentID"_"$i".pdf"
			# echo $studentID"_"$i".pdf"
		done
	fi
done

#insert data colnames
echo studemtID, pages, lines, words, chars, >> result.csv

#count lines, words, chars, filename, studentID
for file in *.pdf;
do
	studentID=$(echo $file | sed -e 's/_.\..*//')

	filemeta=($(wc $file))
	lines=${filemeta[0]}
	words=${filemeta[1]}
	chars=${filemeta[2]}
	filename=${filemeta[3]}
	# # filename get student ID
	# studentID=$(echo $filename | sed -e 's/\..*//')

	#get pages
	pages=$(mdls -name kMDItemNumberOfPages -raw $file)

	#output
	echo $studentID,$pages,$lines,$words,$chars >> result.csv;
	# echo $filenumber >> result.csv;
done
