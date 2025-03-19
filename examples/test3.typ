
#let darkblue = rgb("000099")
#show cite: set text(fill: darkblue)
// #show link: set text(fill: darkblue)


// #let get-text(link-el) = {
//   if link-el.body.has("child") {
//     link-el.body.at("child").text
//   } else {
//     link-el.body.text
//   }
// }

#let link-bib-urls(link-fill: blue, content) = {
  show link: it => {
    if it.body.text == it.dest { // apply only to original link
      it.body
    } else if "https://doi.org/" + it.body.text == it.dest { // for DOI links
      it.body
    } else {
      it
    }
  }

  // this show rule matches the magic prefixes and suffixes ...
  let link-magic = regex("<<<(.*)\|\|\|\s*(.*)>>>")
  show link-magic: it => {
    // ... and renders it as a custom link
    set text(fill: link-fill)
    link(..it.text.matches(link-magic).first().captures)
  }

  let italic-link-magic = regex("<_<(.*)\|\|\|\s*(.*)>_>")
  show italic-link-magic: it => {
    // ... and renders it as a custom link
    set text(fill: link-fill)
    text(style: "italic")[#link(..it.text.matches(italic-link-magic).first().captures)]
  }

  content
}

 

// // minimal example that shows that regex does not match across styled content
// #show regex("aaa"): "bbb"
// a#text(style: "italic")[aa]




= Introduction

Let's cite:
- a conference paper (bibtex entry has both DOI and URL, DOI wins): @bender-koller-2020-climbing
- a journal paper (bibtex entry only has a DOI): @kuhlmann-etal-2015-lexicalization
- a book (bibtex entry only has an URL): @GareyJohnsonBook
- a "Misc" Arxiv paper (bibtex entry only has URL): @yao2023predictinggeneralizationperformancecorrectness

#link-bib-urls(link-fill: darkblue)[
  #bibliography("custom.bib", style: "./acl-with-macros.csl")
]


