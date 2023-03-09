process buildDB {

    input:
    // path db_file
    path db_name

    output:
    tuple path(db_name), path(hash), path(opts), path(taxo)

    script:
    // db_name = db_file.getParent()

    hash = "${db_name}/hash.k2d"
    opts = "${db_name}/opts.k2d"
    taxo = "${db_name}/taxo.k2d"
    """
    kraken2-build --build --db ${db_name}
    """
}