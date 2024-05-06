Issues with some carriage returns in files, requires conversion to unix/UTF8 with command steps below:
```
tail -q -n +2 /extracts/data/nationwide/*/OMOP/*condition_occurrence*.csv > /tmp/nationwide/condition_occurrence.csv
cat condition_occurrence.csv | dos2unix | psql -d nationwide -c "\copy omopcdm.src_condition_occurrence FROM STDIN CSV DELIMITER E','"
```

