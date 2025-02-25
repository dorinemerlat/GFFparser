#' Parse GFF File and Extract Attributes
#'
#' This function reads a GFF file, extracts attributes, and returns a dataframe with the attributes.
#' @param file The path to the GFF file.
#' @return A data frame with the GFF content and extracted attributes.
#' @export
GFFparser <- function(file) {

  # Function to extract attribute values dynamically, now inside gff_parser
  extract_attributes <- function(attr_string, keys) {
    attr_list <- stringr::str_split(attr_string, ";")[[1]]
    attr_dict <- stats::setNames(rep(NA, length(keys)), keys)

    for (attr in attr_list) {
      key_value <- stringr::str_split(attr, "=")[[1]]
      if (length(key_value) == 2) {
        attr_dict[[key_value[1]]] <- key_value[2]
      }
    }
    return(attr_dict)
  }

  # Read the GFF file
  gff <- ape::read.gff(file, na.strings = c(".", "?"), GFF3 = TRUE)

  # Extract unique attribute keys
  attribute_keys <- unique(unlist(stringr::str_extract_all(gff$attributes, "\\b\\w+(?==)")))

  # Apply the internal function to each row and extract attributes
  df_attributes <- as.data.frame(do.call(rbind, lapply(gff$attributes, extract_attributes, keys = attribute_keys)))

  # Merge with the original dataframe, excluding the old attributes column
  `%>%` <- dplyr::`%>%`

  gff_final <- gff %>%
    dplyr::select(-attributes) %>%
    dplyr::bind_cols(df_attributes)

  return(gff_final)
}
