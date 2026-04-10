// ══════════════════════════════════════════════════════════════════════════════
// THEME — Option A: Teal Sidebar
// ══════════════════════════════════════════════════════════════════════════════

// Sidebar
#let sidebar-w      = 6cm           // full sidebar width on page 1
#let sidebar-cont-w = sidebar-w / 3 // continuation stripe on pages 2+ (2cm)
#let sidebar-gap    = 0.7cm         // gap between sidebar edge and text
#let theme-sidebar  = rgb("#147C91")

// Main palette
#let theme-accent  = rgb("#147C91")
#let theme-muted   = luma(0%)

// Typography
#let theme-font    = "New Computer Modern"
#let theme-size    = 10pt
#let theme-leading = 0.65em

// Spacing
#let theme-indent        = 1em
#let theme-entry-gap     = 0.5em
#let theme-section-above = 1.1em
#let theme-section-below = 0.3em

// Identity
#let theme-name    = "Quinn Asena"
#let theme-tagline = "Ecologist & Data Scientist"
#let theme-affil   = "Cary Institute of Ecosystem Studies · Forest Futures Lab"

// Page
#let theme-paper   = "a4"

// ── Sidebar: lab groups, skills, hobbies (edit these) ────────────────────────
// Update URLs to point to the correct lab pages
#let lab-groups = (
  (name: "Forest Futures Lab",      url: "https://forestfutureslab.org/",                          inst: "Cary Institute"),
  (name: "Williams Paleoecology",   url: "https://williamspaleolab.github.io",              inst: "UW-Madison"),
  (name: "Perry Lab",               url: "https://spatialecol.com/", inst: "U. Auckland"),
  (name: "Neotoma Paleoecology DB", url: "https://www.neotomadb.org",                       inst: "Leadership Council"),
)
#let hobbies = ("Classical piano", "Rock climbing", "Art")
#let skills-text = "R · Python · c++ · Bash · HPC · Git"

// ══════════════════════════════════════════════════════════════════════════════
// IMPORTS
// ══════════════════════════════════════════════════════════════════════════════
#import "@preview/fontawesome:0.5.0": *

// ══════════════════════════════════════════════════════════════════════════════
// DATA
// ══════════════════════════════════════════════════════════════════════════════
#let pos-data     = csv("csvs/positions.csv",    row-type: dictionary)
#let pub-data     = csv("csvs/publications.csv", row-type: dictionary)
#let contact-data = csv("csvs/contact_info.csv", row-type: dictionary)

// ══════════════════════════════════════════════════════════════════════════════
// SIDEBAR PANEL (must be defined before #set page)
// ══════════════════════════════════════════════════════════════════════════════
// Maps contact_info.csv icon names → fontawesome package functions
// Solid/regular icons use "Font Awesome 6/7 Free"; brand icons use the Brands font.
#let fa-icon-for(name) = {
  if name == "envelope"         { fa-icon("\u{f0e0}", font: ("Font Awesome 7 Free",)) }
  else if name == "address-card-o" or name == "address-card" { fa-icon("\u{f2bb}", font: ("Font Awesome 7 Free",)) }
  else if name == "github"      { fa-icon("\u{f09b}", font: ("Font Awesome 7 Brands",)) }
  else if name == "linkedin" or name == "linkedin-square" { fa-icon("\u{f0e1}", font: ("Font Awesome 7 Brands",)) }
  else if name == "orcid"       { fa-icon("\u{f8d2}", font: ("Font Awesome 7 Brands",)) }
  else { [] }
}

#let s-head(t) = {
  v(1.5em)  // increased from 0.9em for more breathing room between sections
  text(size: 6.5pt, weight: "bold", fill: white, tracking: 1.5pt)[#upper(t)]
  v(0.05em)
  line(length: 100%, stroke: 0.4pt + luma(100%))
  v(0.35em)
}

#let sidebar-panel = block(width: sidebar-w)[
  #show link: set text(fill: white)
  #set text(fill: white, size: 8.5pt, font: theme-font)
  #pad(left: 0.85cm, right: 0.75cm, top: 2.2cm, bottom: 1.5cm)[

    // Name & identity
    #text(size: 17pt, weight: "bold")[#theme-name]
    #v(0.2em)
    #text(size: 9pt)[#theme-tagline]
    #v(0.05em)
    #text(size: 8pt, fill: luma(100%))[Cary Institute of Ecosystem Studies]
    #v(0.05em)
    #text(size: 8pt, fill: luma(100%))[Forest Futures Lab, New York State]

    // Contact
    #s-head("Contact")
    #for row in contact-data [
      #fa-icon-for(row.icon) #h(0.4em) #link(row.url)[#row.display] \
    ]

    // Lab affiliations
    #s-head("Lab Affiliations")
    #for lg in lab-groups [
      #v(0.05em)
      #link(lg.url)[#lg.name] \
      #text(size: 7.5pt, fill: luma(100%))[#lg.inst]
    ]

    // Skills
    #s-head("Skills & Tools")
    #text(size: 8pt)[#skills-text]

    // Interests
    #s-head("Interests")
    #hobbies.join(" · ")
  ]
]

// ══════════════════════════════════════════════════════════════════════════════
// DOCUMENT SETUP
// ══════════════════════════════════════════════════════════════════════════════
#set document(title: theme-name + " — CV", author: theme-name)
#set page(
  paper:  theme-paper,
  // Page 1 margin: full sidebar + gap. Pages 2+ switch via #set page below.
  margin: (left: sidebar-w + sidebar-gap, right: 1.8cm, top: 2cm, bottom: 2.2cm),
  background: context {
    let p = counter(page).get().first()
    if p == 1 {
      // Page 1: full teal sidebar rect + panel content
      place(top + left, rect(width: sidebar-w, height: 100%, fill: theme-sidebar))
      place(top + left, sidebar-panel)
    } else {
      // Pages 2+: 1/3-width sidebar stripe — same gap to text as page 1
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
// SECTION MANIFEST
// Split into two: page-1 sections (wide sidebar margin) and page-2+ sections
// (narrower margin). Adjust the split if page 1 overflows or has too much space.
// ══════════════════════════════════════════════════════════════════════════════
#let manifest-p1 = (
  (key: "work_positions",     label: "Professional Experience"),
  (key: "research_positions", label: "Research Experience"),
)
#let manifest-p2 = (
  (key: "teaching_positions", label: "Teaching Experience"),
  (key: "education",             label: "Education"),
  (key: "publications",          label: "Publications"),
  (key: "packages",              label: "Software & Open Science"),
  (key: "workshops_conferences", label: "Conferences, Talks & Workshops"),
  (key: "paper_review",          label: "Peer Review"),
  (key: "other",                 label: "Service & Leadership"),
)

// ══════════════════════════════════════════════════════════════════════════════
// HELPERS
// ══════════════════════════════════════════════════════════════════════════════
#let parse-inline(s) = {
  let link-pat = regex("\[([^\]]+)\]\(([^)]+)\)")
  let bold-pat = regex("\*\*([^*]+)\*\*")
  let result = ()
  let rem = s
  while rem.len() > 0 {
    let lm = rem.match(link-pat)
    let bm = rem.match(bold-pat)
    let use-link = lm != none and (bm == none or lm.start <= bm.start)
    let use-bold = bm != none and (lm == none or bm.start < lm.start)
    if use-link {
      if lm.start > 0 { result.push(rem.slice(0, lm.start)) }
      result.push(link(lm.captures.at(1))[#lm.captures.at(0)])
      rem = rem.slice(lm.end)
    } else if use-bold {
      if bm.start > 0 { result.push(rem.slice(0, bm.start)) }
      result.push(strong[#bm.captures.at(0)])
      rem = rem.slice(bm.end)
    } else {
      result.push(rem)
      rem = ""
    }
  }
  result.join()
}

#let section(title) = {
  v(theme-section-above)
  block(below: 0.15em)[
    #text(size: 10.5pt, weight: "bold", fill: theme-accent, tracking: 0.8pt)[#upper(title)]
  ]
  line(length: 100%, stroke: 0.5pt + theme-accent)
  v(theme-section-below)
}

#let cventry(title: [], org: none, loc: none, dates: none, body: none) = {
  grid(
    columns: (1fr, auto), gutter: 1em,
    // Left: title bold, then location muted below
    block[
      *#title*
      #if loc != none { linebreak(); text(size: 9pt, fill: theme-muted, style: "italic")[#loc] }
    ],
    // Right: institution top, dates below
    align(right)[
      #if org != none   { text(size: 9pt, style: "italic")[#org] }
      #if org != none and dates != none { linebreak() }
      #if dates != none { text(size: 9pt, style: "italic", fill: theme-muted)[#dates] }
    ],
  )
  if body != none { v(0.12em); pad(left: theme-indent, body) }
  v(theme-entry-gap)
}

#let render-pub(row) = {
  set list(tight: true, marker: [•])
  list(block(below: 0.45em, above: 0em)[
    #parse-inline(row.authors) (#row.year).
    #if row.url != "" { link(row.url)[#row.title] } else { [#row.title] }.
    #emph[#row.journal].
    #if row.note != "" {
      if row.note_url != "" { link(row.note_url)[#row.note] } else { [#row.note] }
    }
  ])
}

#let render-review-table(rows) = table(
  columns: (auto, 1fr), stroke: none, inset: (x: 0em, y: 0.28em),
  ..rows.map(r => (text(style: "italic")[#r.title], [#r.institution])).flatten()
)

#let dates-str(row) = {
  let (s, e) = (row.start, row.end)
  if s == "" and e == "" { none }
  else if s == e { s }
  else if s == "" { e }
  else if e == "" { s }
  else { s + " – " + e }
}

#let render-row(row, show-dates: true) = {
  let title-c = if row.url != "" { link(row.url)[#row.title] } else { [#row.title] }
  let descs = (row.description_1, row.description_2, row.description_3).filter(d => d != "")
  cventry(
    title: title-c,
    org:   if row.institution != "" { row.institution } else { none },
    loc:   if row.loc != "" { row.loc } else { none },
    dates: if show-dates { dates-str(row) } else { none },
    body:  if descs.len() == 0 { none } else { list(..descs.map(d => parse-inline(d))) },
  )
}

#let render-section(key, label) = {
  section(label)
  if key == "publications" {
    for row in pub-data { if row.in_resume == "TRUE" { render-pub(row) } }
  } else if key == "paper_review" {
    render-review-table(pos-data.filter(r => r.section == key and r.in_resume == "TRUE"))
  } else if key == "packages" {
    for row in pos-data {
      if row.section == key and row.in_resume == "TRUE" { render-row(row, show-dates: false) }
    }
  } else {
    for row in pos-data {
      if row.section == key and row.in_resume == "TRUE" { render-row(row) }
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CONTENT — Page 1: wide sidebar margin
// ══════════════════════════════════════════════════════════════════════════════

#section("Research Interests")
I’m interested in ecological dynamics and mechanisms that underlie change in
ecosystems over time and space. My research focuses on biotic interactions and
how ecosystems respond to environmental and climate change. Much of my previous
research has focused on long-term ecological trajectories and palaeoecology.
I am now exploring contemporary ecosystem change through process-based models.



#for entry in manifest-p1 {
  render-section(entry.key, entry.label)
}

// ══════════════════════════════════════════════════════════════════════════════
// PAGE 2+ — Switch to narrower left margin (sidebar-cont-w + same gap).
// #set page triggers an implicit page break before the new settings take effect.
// Move this call up or down relative to manifest-p1/p2 to control the split.
// ══════════════════════════════════════════════════════════════════════════════

#set page(margin: (left: sidebar-cont-w + sidebar-gap, right: 1.8cm, top: 2cm, bottom: 2.2cm))

#for entry in manifest-p2 {
  render-section(entry.key, entry.label)
}
