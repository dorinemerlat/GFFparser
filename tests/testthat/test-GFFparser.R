test_that("GFFparser correctly parses a valid GFF file", {
  # Create a small GFF file for testing
  test_gff <- tempfile(fileext = ".gff")
  writeLines(c(
    "##gff-version 3",
    "chr1\tsource\tgene\t100\t200\t.\t+\t.\tID=gene1;Name=GeneA",
    "chr1\tsource\tgene\t300\t400\t.\t-\t.\tID=gene2;Name=GeneB"
  ), test_gff)

  # Run GFFparser
  result <- GFFparser(test_gff)

  # Check if output is a data frame
  expect_s3_class(result, "data.frame")

  # Check if required columns exist
  expect_true(all(c("seqid", "source", "type", "start", "end", "strand", "ID", "Name") %in% colnames(result)))

  # Check if attributes are correctly parsed
  expect_equal(result$ID, c("gene1", "gene2"))
  expect_equal(result$Name, c("GeneA", "GeneB"))
})
