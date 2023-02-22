process classify {
    publishDir "${params.outdir}", mode: 'copy'

    input:
    tuple path(db_name), path(hash), path(opts), path(taxo)
    tuple val(sample), path(fq1), path(fq2) 

    output:
    path kreport
    path out

    script:
    // db_name = hash.getParent()
    kreport = "${sample}_kraken_report.kreport"
    out = "${sample}_kraken_report.kraken"
    """
    kraken2 --use-names --db ${db_name} \
    --paired \
    --report ${kreport} \
    --output ${out} \
    ${fq1} ${fq2}
    """
}