
#let link-bib-urls(bibsrc, content) = {
  let p = plugin("blinky.wasm")
  let serialized = p.get_bib_map(bytes(bibsrc))
  let bib_map = cbor(serialized)
  let bib_re = regex("!!BIBENTRY!([^!]+)!!")

  show bib_re: it => {
    let (key,) = it.text.match(bib_re).captures
    let entry = bib_map.at(key, default: "")

    if entry == "" {
      it
    } else {
      let title = entry.fields.title
      let url = entry.fields.at("url", default: "")
      let doi = entry.fields.at("doi", default: "")

      if doi != "" {
        let url = "https://doi.org/" + doi
        link(url)[#title]
      } else if url != "" {
        link(url)[#title]
      } else {
        [#title]
      } 
    }
  }

  content
}
