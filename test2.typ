
#let bib_re = regex("(?s)!!BIBENTRY!([^!]+)!([^!]+)!!")
#show link: set text(blue)

#show bib_re: it => {
    let (a,b) = it.text.match(bib_re).captures
    [(#a) (#b)]
}

This works: !!BIBENTRY!title!url!!

This does not work:
#hide([@paperkey])

#let bibstr = "@inproceedings{paperkey, title = \"Paper title\", author = \"Author1 and Author2\", booktitle = \"Proceedings of Conf\", year = \"2020\", url=\"https://aclanthology.org/2020.acl-main.463\"}"

#bibliography(bytes(bibstr), style: "association-for-computational-linguistics-blinky-0.2.csl")