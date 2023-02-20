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
    } else {
        db_ch = buildDB(hash)
    }

    // classify based on built database
    classify(db_ch)
}