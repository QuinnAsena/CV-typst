// ══════════════════════════════════════════════════════════════════════════════
// 3-PAGE CV — PAGES Data Science Officer application (Bern, deadline 2 Nov 2026)
// https://pastglobalchanges.org/jobs/139102
//
// Same theme and CSVs as cv-a-sidebar.typ, so the content cannot drift. The posting
// asks for "a CV with a full output list, limited to 3 pages maximum": every
// publication is kept, everything else is compacted to one-line entries.
// Row selection lives in this file (the `exclude-*` lists), so `in_resume` in the
// CSVs stays the switch for the full CV.
// ══════════════════════════════════════════════════════════════════════════════

// Sidebar
#let sidebar-w      = 6cm
#let sidebar-cont-w = sidebar-w / 3
#let sidebar-gap    = 0.7cm
#let theme-sidebar  = rgb("#147C91")

// Main palette
#let theme-accent  = rgb("#147C91")
#let theme-muted   = luma(35%)

// Typography
#let theme-font    = "New Computer Modern"
#let theme-size    = 9.5pt
#let theme-leading = 0.6em

// Spacing (tighter than the full CV)
#let theme-indent        = 1em
#let theme-entry-gap     = 0.35em
#let theme-compact-gap   = 0.26em
#let theme-section-above = 0.9em
#let theme-section-below = 0.8em

// Identity
#let theme-name    = "Quinn Asena"
#let theme-tagline = "Data Scientist & Ecologist"

// Page
#let theme-paper   = "a4"

// ── Sidebar ──────────────────────────────────────────────────────────────────
#let lab-groups = (
  (name: "Forest Futures Lab",      url: "https://forestfutureslab.org/",        inst: "Cary Institute"),
  (name: "Williams Paleoecology",   url: "https://williamspaleolab.github.io",   inst: "UW-Madison"),
  (name: "Perry Lab",               url: "https://spatialecol.com/",             inst: "U. Auckland"),
  (name: "Neotoma Paleoecology DB", url: "https://www.neotomadb.org",            inst: "Leadership Council"),
)
#let hobbies = ("Classical piano", "Rock climbing", "Art")
#let skills-text = "R · Python · C++ · Bash · SQL · Apache Arrow · Git/GitHub · Quarto · Shiny · HPC (Slurm/PBS)"
// The posting's "advantage" items, surfaced where a reader looks first.
#let methods-items = ("State-space time-series models", "Age-depth modelling (Bchron)", "Pseudoproxy / virtual ecology", "Machine learning for spatial data", "Neotoma database & standards", "FAIR/CARE data stewardship")

// Rows hidden in this version (matched on the CSV `title` column).
#let exclude-talks = (
  "Durham University - Invited Speaker",
  "Biological Heritage Science Challenge",
)
#let exclude-education = ("Performance Composition & Theory",)

// ══════════════════════════════════════════════════════════════════════════════
// IMPORTS & DATA
// ══════════════════════════════════════════════════════════════════════════════
#import "@preview/fontawesome:0.5.0": *

#let pos-data     = csv("csvs/positions.csv",    row-type: dictionary)
#let pub-data     = csv("csvs/publications.csv", row-type: dictionary)
#let contact-data = csv("csvs/contact_info.csv", row-type: dictionary)

#let rows-for(key, exclude: ()) = pos-data.filter(r =>
  r.section == key and r.in_resume == "TRUE" and r.title not in exclude)

// ══════════════════════════════════════════════════════════════════════════════
// SIDEBAR PANEL
// ══════════════════════════════════════════════════════════════════════════════
#let fa-icon-for(name) = {
  if name == "envelope"         { fa-icon("\u{f0e0}", font: ("Font Awesome 7 Free",)) }
  else if name == "address-card-o" or name == "address-card" { fa-icon("\u{f2bb}", font: ("Font Awesome 7 Free",)) }
  else if name == "github"      { fa-icon("\u{f09b}", font: ("Font Awesome 7 Brands",)) }
  else if name == "linkedin" or name == "linkedin-square" { fa-icon("\u{f0e1}", font: ("Font Awesome 7 Brands",)) }
  else if name == "orcid"       { fa-icon("\u{f8d2}", font: ("Font Awesome 7 Brands",)) }
  else { [] }
}

#let s-head(t) = {
  v(1.3em)
  text(size: 6.5pt, weight: "bold", fill: white, tracking: 1.5pt)[#upper(t)]
  v(0.05em)
  line(length: 100%, stroke: 0.4pt + luma(100%))
  v(0.35em)
}

#let sidebar-panel = block(width: sidebar-w)[
  #show link: set text(fill: white)
  #show link: underline.with(offset: 0.18em, stroke: 0.4pt + rgb(255, 255, 255, 150))
  #set text(fill: white, size: 8.5pt, font: theme-font)
  #set par(justify: false)
  #pad(left: 0.85cm, right: 0.75cm, top: 2.2cm, bottom: 1.5cm)[

    #text(size: 17pt, weight: "bold")[#theme-name]
    #v(0.2em)
    #text(size: 9pt)[#theme-tagline]
    #v(0.05em)
    #text(size: 8pt)[Cary Institute of Ecosystem Studies]
    #v(0.05em)
    #text(size: 8pt)[Forest Futures Lab, Millbrook, NY]

    #s-head("Contact")
    #for row in contact-data [
      #fa-icon-for(row.icon) #h(0.4em) #link(row.url)[#row.display] \
    ]

    #s-head("Lab Affiliations")
    #for lg in lab-groups [
      #v(0.05em)
      #link(lg.url)[#lg.name] \
      #text(size: 7.5pt)[#lg.inst]
    ]

    #s-head("Methods & Data")
    #text(size: 8pt)[#methods-items.join(linebreak())]

    #s-head("Skills & Tools")
    #text(size: 8pt)[#skills-text]

    #s-head("Interests")
    #hobbies.join(" · ")
  ]
]

// ══════════════════════════════════════════════════════════════════════════════
// DOCUMENT SETUP
// ══════════════════════════════════════════════════════════════════════════════
#set document(title: theme-name + " CV", author: theme-name)
#set page(
  paper:  theme-paper,
  margin: (left: sidebar-w + sidebar-gap, right: 1.6cm, top: 1.5cm, bottom: 1.7cm),
  background: context {
    let p = counter(page).get().first()
    if p == 1 {
      place(top + left, rect(width: sidebar-w, height: 100%, fill: theme-sidebar))
      place(top + left, sidebar-panel)
    } else {
      place(top + left,
        rect(width: sidebar-cont-w, height: 100%, fill: theme-sidebar,
             radius: (right: 3pt))
      )
    }
  },
  footer: context [
    #set text(size: 7.5pt, fill: theme-muted)
    #h(1fr) #theme-name · CV · #counter(page).display("1 of 1", both: true)
  ],
)
#set text(font: theme-font, size: theme-size, lang: "en")
#set par(leading: theme-leading, justify: true)
#show link: set text(fill: theme-accent)

// ══════════════════════════════════════════════════════════════════════════════
// HELPERS
// ══════════════════════════════════════════════════════════════════════════════
// Inline markup for CSV text: [text](url), **bold**, _italic_, ^superscript^.
// The earliest match wins; on a tie the earlier pattern in this list wins.
#let inline-pats = (
  (regex("\[([^\]]+)\]\(([^)]+)\)"), m => link(m.captures.at(1))[#m.captures.at(0)]),
  (regex("\*\*([^*]+)\*\*"),         m => strong[#m.captures.at(0)]),
  (regex("_([^_]+)_"),               m => emph[#m.captures.at(0)]),
  (regex("\^([^^]+)\^"),             m => super[#m.captures.at(0)]),
)

#let parse-inline(s) = {
  let result = ()
  let rem = s
  while rem.len() > 0 {
    let best = none
    for (pat, render) in inline-pats {
      let m = rem.match(pat)
      if m != none and (best == none or m.start < best.at(0).start) { best = (m, render) }
    }
    if best == none {
      result.push(rem)
      rem = ""
    } else {
      let (m, render) = best
      if m.start > 0 { result.push(rem.slice(0, m.start)) }
      result.push(render(m))
      rem = rem.slice(m.end)
    }
  }
  result.join()
}

#let section(title) = {
  v(theme-section-above)
  block(sticky: true, inset: (bottom: theme-section-below), below: 0em)[
    #block(below: 0.15em)[
      #text(size: 10.5pt, weight: "bold", fill: theme-accent, tracking: 0.8pt)[#upper(title)]
    ]
    #line(length: 100%, stroke: 0.5pt + theme-accent)
  ]
}

#let dates-str(row) = {
  let (s, e) = (row.start, row.end)
  if s == "" and e == "" { none }
  else if s == e { s }
  else if s == "" { e }
  else if e == "" { s }
  else { s + " – " + e }
}

#let muted(body) = text(size: 9pt, style: "italic", body)

#let first-descs(row, n) = {
  let all = (row.description_1, row.description_2, row.description_3).filter(d => d != "")
  all.slice(0, calc.min(n, all.len()))
    .map(d => if d.ends-with(regex("[.!?]")) { d } else { d + "." })
    .map(parse-inline)
}

// Full entry: title + institution on the left, location + dates on the right, bullets below.
// `n-desc` caps how many CSV description columns are shown.
#let render-full(row, n-desc: 3) = {
  let descs = first-descs(row, n-desc)
  grid(
    columns: (1fr, auto), gutter: 1em,
    block[
      *#row.title*
      #if row.institution != "" { linebreak(); muted(row.institution) }
    ],
    align(right)[
      #if row.loc != "" { text(size: 9pt, style: "italic")[#row.loc]; linebreak() }
      #muted(dates-str(row))
    ],
  )
  if descs.len() > 0 {
    v(0.1em)
    pad(left: theme-indent, list(tight: true, ..descs))
  }
  v(theme-entry-gap)
}

// One-line entry: *title*, institution, location: first description(s); dates right.
// `sep` joins the name to the description; talks use ";" because their descriptions
// already open with "Speaker:" / "Poster:".
// `short` drops the spelled-out name after " - " in conference titles.
#let render-compact(row, n-desc: 1, show-dates: true, show-loc: true, short: false, sep: ":") = {
  let descs = first-descs(row, n-desc)
  let title = if short { row.title.split(" - ").first() } else { row.title }
  let where = (row.institution, if show-loc { row.loc } else { "" }).filter(s => s != "")
  grid(
    columns: (1fr, auto), gutter: 1em,
    par(justify: false)[
      *#if row.url != "" { link(row.url)[#title] } else { title }*#if where.len() > 0 [, #muted(where.join(", "))]#if descs.len() > 0 [#sep #descs.join(" ")]
    ],
    if show-dates { muted(dates-str(row)) } else { [] },
  )
  v(theme-compact-gap)
}

#let render-pub(row) = {
  set list(tight: true, marker: [•])
  list(block(below: 0.4em, above: 0em)[
    #parse-inline(row.authors) (#row.year.replace(" ", "\u{00A0}")).
    #if row.url != "" { link(row.url)[#parse-inline(row.title)] } else { emph[#parse-inline(row.title)] }.
    #if row.journal != "" [#emph[#row.journal].]
    #if row.note != "" {
      if row.note_url != "" { link(row.note_url)[#row.note] } else { [#row.note] }
    }
  ])
}

// ══════════════════════════════════════════════════════════════════════════════
// CONTENT — Page 1: wide sidebar margin
// ══════════════════════════════════════════════════════════════════════════════

#section("Profile")

I am an *ecologist and data scientist* focused on how ecosystems change over time
and space, and on building the data infrastructure needed to study them.
My current work includes deep learning methods for *wildfire risk mapping*,
and process-based *landscape simulations* to project forest biodiversity change.
My PhD and postdoctoral research focused on palaeoecology and statistical method
development to analyse irregular time series data. I currently serve as early career
representative on the *Neotoma Paleoecology Database Leadership Council*.


#section("Professional Experience")
#for row in rows-for("work_positions") {
  if row.title == "Data Scientist" or row.title == "Postdoctoral Research Associate" {
    render-full(row)
  } else {
    render-compact(row, show-loc: false)
  }
}
#for row in rows-for("research_positions") { render-compact(row, show-loc: false) }

#section("Education")
#for row in rows-for("education", exclude: exclude-education) {
  render-compact(row, n-desc: if row.title.starts-with("PhD") { 2 } else { 1 }, show-loc: false)
}

// ══════════════════════════════════════════════════════════════════════════════
// PAGE 2+ — narrower left margin (forces a page break)
// ══════════════════════════════════════════════════════════════════════════════
#set page(margin: (left: sidebar-cont-w + sidebar-gap, right: 1.6cm, top: 1.5cm, bottom: 1.7cm))

#section("Publications")
#for row in pub-data { if row.in_resume == "TRUE" { render-pub(row) } }

#section("Software & Open Science")
#for row in rows-for("packages") { render-compact(row, show-dates: false, show-loc: false) }

#section("Service & Leadership")
#for row in rows-for("other") { render-compact(row, show-loc: false) }

#section("Selected Talks, Workshops & Conferences")
#for row in rows-for("workshops_conferences", exclude: exclude-talks) {
  render-compact(row, n-desc: 2, short: true, sep: ";")
}

#section("Teaching")
#for row in rows-for("teaching_positions") { render-compact(row, n-desc: 2, show-loc: false) }

#section("Peer Review")
Reviewer for
#rows-for("paper_review").map(r => emph(r.title)).join(", ", last: ", and ").
