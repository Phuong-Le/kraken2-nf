process classify [
    publishDir "${params.outdir}", mode: 'copy'

    input:
    tuple path(hash), path(opts), path(taxo)
    tuple val(sample), path(fq1), path(fq2) 

    output:
    path "kraken_report.kreport"
    path "kraken_report.kraken"

    script:
    db_name = db_file.getParent()
    """
    kraken2 --use-names --db ${db_name} \
    --paired \
    --report kraken_report.kreport \
    --output kraken_report.kraken \
    ${fq1} ${fq2}
    """
]