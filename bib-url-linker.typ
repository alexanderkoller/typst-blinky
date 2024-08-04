



#let p = plugin("bib_url_linker.wasm")

#let bib_re = regex("!!BIBENTRY!([^!]+)!!")

// bibliography(
// strarray,
// title: noneautocontent,
// full: bool,
// style: str,
// ) -> content

#let url-bibliography(strarray, title: auto, full: false, style: "ieee") = {
  let bibsrc = read(strarray) // TODO: handle case with multiple bibliographies
  let serialized = p.get_bib_map(bytes(bibsrc))
  let bib_map = cbor.decode(serialized)

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

  bibliography(strarray, title: title, full: full, style: style)
}