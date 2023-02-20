#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { buildDB } from './modules/buildDN.nf'
include { classify } from './modules/classify.nf'

workflow {
    // if db doesn't exist then buildDB
    hash = file("${params.db}/hash.k2d")
    opts = file("${params.db}/opts.k2d")
    taxo = file("${params.db}/taxo.k2d")
    if ( hash.exists() && opts.exists() && taxo.exists() ) {
        println "kraken database exists, proceed to classification"
        // indices = Channel.fromPath('*.bt2')
        //                     .collect()
        db_ch = Channel.fromPath("${params.db}/*.k2d")
                            .collect()
    } else {
        db_ch = buildDB(hash).collect()
    }

    // classify based on built database
    def sample_params = file(params.sample_params)
    sample_param_ch = Channel.of(sample_params.text)
        .splitCsv( sep : '\t')
        .map { row -> tuple( row[0], row[1], row[2] ) }
    classify(db_ch, sample_param_ch)
}