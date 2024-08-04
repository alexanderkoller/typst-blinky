#import "@local/bib-url-linker:0.1.0": link-bib-urls

#let darkblue = rgb("000099")
#show cite: set text(fill: darkblue)
#show link: set text(fill: darkblue)

= Introduction

We are citing one paper @damonte-monti-2021-one,
and then another @li-etal-2017-modeling.

#let bibsrc = read("custom.bib")
#link-bib-urls(bibsrc)[
  #bibliography("custom.bib", style: "./association-for-computational-linguistics.csl")
]

