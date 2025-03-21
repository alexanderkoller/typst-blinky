use wasm_minimal_protocol::*;
use biblatex::*;
use core::str;
use std::collections::BTreeMap;

// Importing this (or something else that accesses the console) will cause weird errors of the form
// error: cannot find definition for import __wbindgen_placeholder__::__wbindgen_describe with type Func(FuncType { params: [I32], results: [] })
// use wasm_bindgen::prelude::*;
// use web_sys::console;

initiate_protocol!();

use serde_derive::{Deserialize, Serialize};
use serde_cbor::to_vec;



// must pass bib contents as parameter here because the plugin
// runs in a sandbox that does not allow file access

#[derive(Debug, Serialize, Deserialize)]
struct MyEntry {
    entry_type: String,
    entry_key: String,
    fields: BTreeMap<String, String>
}

#[wasm_func]
pub fn get_bib_map(bib_contents_u8: &[u8]) -> Vec<u8> {
    let bib_contents = str::from_utf8(bib_contents_u8).unwrap();
    let bibliography = Bibliography::parse(bib_contents).unwrap();

    let mut ret: BTreeMap<String, MyEntry> = BTreeMap::new();
    
    for entry in bibliography.iter() {
        ret.insert(entry.key.clone(), convert_entry(entry));
    }

    return to_vec(&ret).unwrap();
}


fn convert_chunks_to_string(chunks: &Chunks) -> String {
    // You can choose the formatting method here; for example, to use `format_verbatim`
    chunks.format_verbatim()
}

fn insert_converted_fields(
    original_map: BTreeMap<String, Chunks>, 
    target_map: &mut BTreeMap<String, String>
) {
    for (key, value) in original_map {
        // Convert the `Chunks` into a `String`
        let converted_value = convert_chunks_to_string(&value);
        
        // Insert into the target map
        target_map.insert(key, converted_value);
    }
}

fn create_entry(entry_type: String, entry_key: String) -> MyEntry {
    return MyEntry { entry_key: entry_key, entry_type: entry_type, fields: BTreeMap::new() };
}

// fn first_last(person: &Person) -> String {
//     return format!("{} {}", person.given_name, person.name);
// }

fn convert_entry(entry:&Entry) -> MyEntry {
    let mut ret = create_entry(entry.entry_type.to_string(), entry.key.clone());

    let title = entry.title().unwrap().format_sentence();
    // let authors = entry.author().unwrap();
    // let formatted_authors: Vec<String> = authors.iter().map(|person| first_last(person) ).collect();

    ret.fields.insert("title".to_string(), title);
    // ret.fields.insert("author".to_string(), formatted_authors.join(" and "));

    insert_converted_fields(entry.fields.clone(), &mut ret.fields);

    match entry.url() {
        Ok(url) => ret.fields.insert("url".to_string(), url),
        _ => Some("".to_string())
    };

    match entry.doi() {
        Ok(doi) => ret.fields.insert("doi".to_string(), doi),
        _ => Some("".to_string())
    };

    // let keys: String = entry.fields.keys()
    //                       .map(|key| key.to_string())
    //                       .collect::<Vec<String>>()
    //                       .join(", "); // Join the keys with commas

    

    // ret.fields.insert("fields".to_string(), keys.to_string());

    return ret;
}


