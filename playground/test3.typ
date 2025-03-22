
#let darkblue = rgb("000099")
#show cite: set text(fill: darkblue)


#let link-bib-urls(link-fill: blue, content) = {
  // Typst converts URLs and DOIs into links -- get rid of the links and
  // restore the actual URLs and DOIs, otherwise the regexes don't match.
  show link: it => {
    if it.body.text == it.dest { // apply only to original link
      it.body
    } else if "https://doi.org/" + it.body.text == it.dest { // for DOI links
      it.body
    } else {
      it
    }
  }

  // Match the magic pattern for <<<url|||title>>> and replace by links.
  // These code snippets are by user Philipp on the Typst forum,
  // https://forum.typst.app/t/how-can-i-configure-linking-and-color-in-my-bibliography
  let link-magic = regex("<<<(.*)\|\|\|\s*(.*)>>>")
  show link-magic: it => {
    set text(fill: link-fill)
    link(..it.text.matches(link-magic).first().captures)
  }

  // Match the magic pattern for <_<url||title>_> and replace by
  // links styled in italics.
  let italic-link-magic = regex("<_<(.*)\|\|\|\s*(.*)>_>")
  show italic-link-magic: it => {
    set text(fill: link-fill)
    text(style: "italic")[#link(..it.text.matches(italic-link-magic).first().captures)]
  }

  content
}



= Introduction

Let's cite:
- a conference paper (bibtex entry has both DOI and URL, DOI wins): @bender-koller-2020-climbing
- a journal paper (bibtex entry only has a DOI): @kuhlmann-etal-2015-lexicalization
- a book (bibtex entry only has an URL): @GareyJohnsonBook
- a "Misc" Arxiv paper (bibtex entry only has URL): @yao2023predictinggeneralizationperformancecorrectness

#link-bib-urls(link-fill: darkblue)[
  #bibliography("custom.bib", style: "./acl-with-macros.csl")
]


