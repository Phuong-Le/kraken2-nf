process buildDB {
    publishDir "${params.db_dir}", mode: 'copy'

    input:
    path db_file

    output:
    tuple path(hash), path(opts), path(taxo)

    script:
    db_name = db_file.getParent()
    hash = 'hash.k2d'
    opts = 'opts.k2d'
    taxo = 'taxo.k2d'
    """
    kraken2-build --build --db ${db_name}
    """
}