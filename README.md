# GFFparser

GFFparser is an R package designed to parse GFF (General Feature Format) files and extract their attribute information into a clean dataframe for further analysis.

## Installation

You can install the GFFparser package directly from GitHub using remotes:

```r
remotes::install_github("dorinemerlat/GFFparser")
```

## Usage

```r
gff_parser(file)
``` 

This function reads a GFF file and returns a dataframe with the parsed content and extracted attributes.

Arguments:

- `file`: The path to the GFF file (must be in GFF3 format).

Example:
```r
# Load the package
library(GFFparser)

# Parse the GFF file
gff_data <- gff_parser("/path/to/your/file.gff")

# View the parsed dataframe
head(gff_data)
```

## Dependencies

The package relies on the following R packages:

- `ape`
- `dplyr`
- `stringr`
- `purrr`
- `tidyr`

These will be installed automatically when you install `GFFparser` from GitHub.

## License

This package is licensed under the GNU General Public License v3.0.

## Contact

For questions, suggestions, or issues, please contact me (dorine.merlat@etu.unistra.fr).
