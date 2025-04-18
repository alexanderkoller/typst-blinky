
= Blinky with regex on CSL outputs
#v(1em)


/*
in principle, show rules get chained:


#show "aaa": "bbb"
#show "bbb": "ccc"

aaa
*/



In this document, we have a regex show rule that matches an URL-title pair and typesets it as a link. This works correctly when the matched string is inserted from a file (it won't work when the string is in the Typst source file, because then two double slashes become a comment).

When the matched string is generated by CSL, the regex does not match because Typst makes DOIs und URLs `#link` elements, which are not matched by the regex. The obvious solution would be to prevent Typst from overeagerly creating these link elements.

If, as in the current experimental version, the DOI is stored in the `note` field (rather than `DOI`), the regex matches and the title is typeset as a hyperlink.


#let bib_re = regex("(?s)!!BIBENTRY!([^!]+)!([^!]+)!!")
#show link: set text(blue)

#show bib_re: it => {
    let (a,b) = it.text.match(bib_re).captures
    [(#a) (#b)]
    // link(a)[#b]
}

#let x = read("x.txt")
#x

@bender-koller-2020-climbing

#show bibliography: it => {
  show link: it => it.body
  it
}

// #show link: it => context {
//   [#here().position()]
//   it 
// }

// #show link: it => it.body

#bibliography("examples/custom.bib", style: "examples/association-for-computational-linguistics-blinky-0.2.csl")