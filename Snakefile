rule all:
    input:        
        "all.cmp.hist.png",
        "all.cmp.dendro.png",
        "all.cmp.matrix.png"

rule link_data:
    output: 
        "1.fa.gz",
        "2.fa.gz",
        "3.fa.gz",
        "4.fa.gz",
        "5.fa.gz",
        "6.fa.gz",
        "7.fa.gz",
        "8.fa.gz",
        "9.fa.gz"

    shell:
        """wget https://osf.io/t5bu6/download -O 1.fa.gz
wget https://osf.io/ztqx3/download -O 2.fa.gz
wget https://osf.io/w4ber/download -O 3.fa.gz
wget https://osf.io/dnyzp/download -O 4.fa.gz
wget https://osf.io/ajvqk/download -O 5.fa.gz
wget https://osf.io/ztqx3/download -O 6.fa.gz
wget https://osf.io/w4ber/download -O 7.fa.gz
wget https://osf.io/dnyzp/download -O 8.fa.gz
wget https://osf.io/ajvqk/download -O 9.fa.gz"""

rule sourmash_compute:
    input: 
        "{name}.fa.gz"
    output:
        "{name}.fa.gz.sig"
    shell:
        "sourmash compute -k 31 {input} -o {output}"


rule sourmash_compare:
    input:
        "1.fa.gz.sig",
        "2.fa.gz.sig",
        "3.fa.gz.sig",
        "4.fa.gz.sig",
        "5.fa.gz.sig",
        "6.fa.gz.sig",
        "7.fa.gz.sig",
        "8.fa.gz.sig",
        "9.fa.gz.sig"
    output:
        "all.cmp",
        "all.cmp.labels.txt"
    shell:
        "sourmash compare {input} -o all.cmp"
    
rule sourmash_plot:
    input: 
        "all.cmp",
        "all.cmp.labels.txt"
    output: 
        "all.cmp.hist.png",
        "all.cmp.dendro.png",
        "all.cmp.matrix.png"
    shell: 
        "sourmash plot --labels all.cmp"
