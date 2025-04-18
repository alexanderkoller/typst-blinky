

// #let bib_re = regex("(?s)!!BIBENTRY!\s*([^!]+)!\s*([^!]+)!!")
// #show link: set text(blue)

// #show bib_re: it => {
//     let (a,b) = it.text.match(bib_re).captures
//     [(#a) (#b)]
// }


// // this show rule matches the magic prefixes and suffixes ...
// #let link-magic = regex("!!BIBENTRY(.*)!(.*)!!")
// #show link-magic: it => {
//   // ... and renders it as a custom link
//   set text(fill: blue)
//   link(..it.text.matches(link-magic).first().captures)
// }


// this show rule matches the magic prefixes and suffixes ...
#let link-magic = regex("<<<(.*)\|\|\|\s*(.*)>>>")
#show link-magic: it => {
  // ... and renders it as a custom link
  set text(fill: blue)
  link(..it.text.matches(link-magic).first().captures)
}

This works: \<\<\<url|||title\>\>\>

This does not work:
#hide([@paperkey])

 #show link: it => {
    if it.body.text == it.dest { // apply only to original link
      it.body
    } else if "https://doi.org/" + it.body.text == it.dest { // for DOI links
      it.body
    } else {
      it
    }
  }

#let bibstr = "@inproceedings{paperkey, title = \"Paper title\", author = \"Author1 and Author2\", booktitle = \"Proceedings of Conf\", year = \"2020\", url=\"https://aclanthology.org/2020.acl-main.463\"}"

#let bibstr2 = "@inproceedings{paperkey, title = \"Paper title\", author = \"Author1 and Author2\", booktitle = \"Proceedings of Conf\", year = \"2020\"}"

#let bibstr3 = "@inproceedings{paperkey, title = \"Paper title\", author = \"Author1 and Author2\", booktitle = \"Proceedings of Conf\", year = \"2020\", doi=\"10.18653/v1/2020.acl-main.463\"}"

#let bibstr4 = "@inproceedings{paperkey, title = \"Paper title\", author = \"Author1 and Author2\", booktitle = \"Proceedings of Conf\", year = \"2020\", url=\"https://doi.org/10.18653/v1/2020.acl-main.463\"}"



#bibliography(bytes(bibstr2), style: "./examples/acl-with-macros.csl")

#let a = read("x.txt")
#a
