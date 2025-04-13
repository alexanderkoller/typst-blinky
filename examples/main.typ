#import "@local/blinky:0.2.0": link-bib-urls

#let darkblue = rgb("000099")
#show cite: set text(fill: darkblue)

// #show link: set text(fill: darkblue)


= Introduction

Let's cite:
- a conference paper (bibtex entry has both DOI and URL, DOI wins): @bender-koller-2020-climbing
- a journal paper (bibtex entry only has a DOI): @kuhlmann-etal-2015-lexicalization
- a book (bibtex entry only has an URL): @GareyJohnsonBook
- a "Misc" Arxiv paper (bibtex entry only has URL): @yao2023predictinggeneralizationperformancecorrectness


// #let bibsrc = read("custom.bib")
#link-bib-urls(link-fill: darkblue)[
  #bibliography("custom.bib", style: "./association-for-computational-linguistics-blinky.csl")
  // #bibliography("custom.bib", style: "./apa-blinky.csl")
]

