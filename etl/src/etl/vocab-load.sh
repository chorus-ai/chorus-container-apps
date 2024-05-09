#!/bin/bash

psql -d mit -c "\copy vocabulary.concept TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_relationship TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_relationship FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_ancestor TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_ancestor FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_class TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_class FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_recommended TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_recommended FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_synonym TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_synonym FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.concept_hierarchy TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.concept_hierarchy FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.domain TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.domain FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.drug_strength TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.drug_strength FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.relationship TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.relationship FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.source_to_concept_map TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.source_to_concept_map FROM STDIN CSV"

psql -d mit -c "\copy vocabulary.vocabulary TO STDOUT CSV" | psql -d $1 -c "\copy vocabulary.vocabulary FROM STDIN CSV"
