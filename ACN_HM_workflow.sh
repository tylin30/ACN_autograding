cd $1

# rename file to studentID.docx/.pdf
rename 's/^hw\d{6}_([^_]*)_[^_]*_(\d{1,2})/$1_$2/' *.pdf

#count lines, words, chars, filename, studemtID
echo studemtID, pages, lines, words, chars, >> result.csv
for file in *.pdf;
do
	filemeta=($(wc $file))
	lines=${filemeta[0]}
	words=${filemeta[1]}
	chars=${filemeta[2]}
	filename=${filemeta[3]}
	# filename get student ID
	studentID=$(echo $filename | sed -e 's/\..*//')
	#get pages
	pages=$(mdls -name kMDItemNumberOfPages -raw $file)

	#output
	echo $studentID,$pages,$lines,$words,$chars >> result.csv;
done
