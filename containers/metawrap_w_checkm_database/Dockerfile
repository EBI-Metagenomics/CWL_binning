FROM quay.io/biocontainers/metawrap:1.1--0
RUN echo -e "cat << EOF\n/db/CheckM\nEOF\n" | checkm data setRoot

RUN curl -o checkm.tar.gz https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz
RUN zcat checkm.tar.gz | tar -xvf - -C /db/CheckM/ && rm *.gz
