// ══════════════════════════════════════════════════════════════════════════════
// ONE-PAGE CV — compact single-column layout
// Curated highlights only (not CSV-driven): recent work, education, top
// publications, and key software. Edit the CONTENT block below directly.
// ══════════════════════════════════════════════════════════════════════════════

#import "@preview/fontawesome:0.5.0": *

// ── Theme ─────────────────────────────────────────────────────────────────────
#let theme-accent = rgb("#147C91")
#let theme-muted  = luma(35%)
#let theme-font   = "New Computer Modern"

#let theme-name    = "Quinn Asena"
#let theme-tagline = "Data Scientist & Ecologist"

// ── Document setup ──────────────────────────────────────────────────────────
#set document(title: theme-name + " — CV (One Page)", author: theme-name)
#set page(paper: "a4", margin: (left: 2.2cm, right: 2.2cm, top: 2.2cm, bottom: 2.2cm))
#set text(font: theme-font, size: 10pt, lang: "en")
#set par(leading: 0.65em, justify: true, spacing: 0.65em)
#show link: set text(fill: theme-accent)

// ── Helpers ───────────────────────────────────────────────────────────────────
#let fa-icon-for(name) = {
  if name == "envelope"    { fa-icon("\u{f0e0}", font: ("Font Awesome 7 Free",)) }
  else if name == "address-card-o" { fa-icon("\u{f2bb}", font: ("Font Awesome 7 Free",)) }
  else if name == "github" { fa-icon("\u{f09b}", font: ("Font Awesome 7 Brands",)) }
  else if name == "orcid"  { fa-icon("\u{f8d2}", font: ("Font Awesome 7 Brands",)) }
  else { [] }
}

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
  v(0.9em)
  block(below: 0.15em)[
    #text(size: 10.5pt, weight: "bold", fill: theme-accent, tracking: 0.7pt)[#upper(title)]
  ]
  line(length: 100%, stroke: 0.5pt + theme-accent)
  v(0.3em)
}

#let entry(title: [], org: none, loc: none, dates: none, body: none) = {
  grid(
    columns: (1fr, auto), gutter: 1em,
    block[
      *#title*
      #if loc != none { linebreak(); text(size: 8.5pt, fill: theme-muted, style: "italic")[#loc] }
    ],
    align(right)[
      #if org != none   { text(size: 8.5pt, style: "italic")[#org] }
      #if org != none and dates != none { linebreak() }
      #if dates != none { text(size: 8.5pt, style: "italic", fill: theme-muted)[#dates] }
    ],
  )
  if body != none { v(0.12em); pad(left: 1em, body) }
  v(0.5em)
}

#let pub(text-body) = {
  set list(tight: true, marker: [•])
  list(block(below: 0.4em, above: 0em)[#text-body])
}

// ══════════════════════════════════════════════════════════════════════════════
// CONTENT
// ══════════════════════════════════════════════════════════════════════════════

// ── Header ────────────────────────────────────────────────────────────────────
#grid(
  columns: (auto, 1fr), align: (left + bottom, right + bottom), gutter: 1em,
  text(size: 23pt, weight: "bold")[#theme-name],
  text(size: 9.5pt)[
    #box[#fa-icon-for("envelope") #h(0.3em) #link("mailto:asenaq@caryinstitute.org")[asenaq\@caryinstitute.org]] #h(0.6em)
    #box[#fa-icon-for("address-card-o") #h(0.3em) #link("https://quinnasena.github.io/quinn-asena-website/")[quinnasena.github.io]] \
    #box[#fa-icon-for("github") #h(0.3em) #link("https://github.com/QuinnAsena")[github.com/QuinnAsena]] #h(0.6em)
    #box[#fa-icon-for("orcid") #h(0.3em) #link("https://orcid.org/0000-0002-4086-460X")[0000-0002-4086-460X]]
  ],
)
#v(0.15em)
#text(size: 12pt, fill: theme-muted)[#theme-tagline · Cary Institute of Ecosystem Studies, Forest Futures Lab, Millbrook, NY]

#v(0.4em)
#text(size: 9.5pt)[
  Ecologist and data scientist focused on how ecosystems change over time and space, coupling
  process-based landscape simulation with CMIP6 climate scenarios on HPC systems to project
  forest biodiversity change, with a background spanning palaeoecology and statistical modelling.
]

// ── Professional Experience ──────────────────────────────────────────────────
#section("Professional Experience")

#entry(
  title: [Data Scientist], org: "Cary Institute of Ecosystem Studies", loc: "Millbrook, NY",
  dates: "2025 – Present",
  body: list(
    parse-inline("Automated HPC workflows for process-based landscape simulations across boreal North America under multiple CMIP6 climate scenarios."),
    parse-inline("Large-scale data management using SQL and Apache Arrow; integration of climate, soil, and elevation data from distributed archives (NASA DAACs, STAC)."),
  ),
)

#entry(
  title: [Postdoctoral Research Associate], org: "University of Wisconsin-Madison", loc: "Madison, WI",
  dates: "2022 – 2024",
  body: list(
    parse-inline("NSF-funded project developing state-space modelling methods to analyse palaeoecological records, part of the abrupt change in ecosystems project led by Jack Williams and Anthony Ives."),
  ),
)

// ── Education ─────────────────────────────────────────────────────────────────
#section("Education")

#entry(
  title: [PhD, University of Auckland], org: "School of Environment", loc: "Auckland, NZ",
  dates: "2017 – 2021",
  body: list(
    parse-inline("Explored virtual ecological methods for generating pseudoproxy data to assess statistical inferences under data uncertainty. Supervised by George Perry and Janet Wilmshurst."),
  ),
)

#entry(
  title: [MEnv. Environmental Science], org: "University of York", loc: "York, UK",
  dates: "2012 – 2016",
  body: none,
)

// ── Publications ──────────────────────────────────────────────────────────────
#section("Selected Publications")

#pub[
  #parse-inline("**Asena, Q.**, Williams, J., Stefanova, V., Johnson, J., Shuman, B., Ives, A.") (2026).
  #link("https://doi.org/10.1111/2041-210x.70315")[Statistical analyses of ecological multinomial time series to identify environmental drivers and biotic interactions].
  #emph[Methods in Ecology and Evolution]. In press.
]
#pub[
  #parse-inline("**Asena, Q.**, Perry, G.L., Wilmshurst, J.") (2026).
  #link("https://doi.org/10.5194/cp-22-783-2026")[Information loss in palaeoecological data from process and observer error].
  #emph[Climate of the Past].
]
#pub[
  #parse-inline("**Asena, Q.**, Perry, G.L., Wilmshurst, J.") (2024).
  #link("https://doi.org/10.1177/09596836241247304")[Is the past recoverable from the data? Pseudoproxy modelling of uncertainties in palaeoecological data].
  #emph[The Holocene].
]
#pub[
  #parse-inline("Parsons, M., **Asena, Q.**, Johnson, D., Nalau, J.") (2024).
  #link("https://doi.org/10.1016/j.crm.2024.100593")[A Bibliometric Review and Topic Analysis of Climate Justice Literature: Mapping Trends, Voices, and the Way Forward].
  #emph[Climate Risk Management].
]

// ── Software & Open Science ──────────────────────────────────────────────────
#section("Software & Open Science")

#pub[
  #link("https://github.com/QuinnAsena/multinomialTS")[*multinomialTS*] — R package for state-space modelling of multinomially distributed ecological time-series data. (2024)
]
#pub[
  #link("https://quinnasena.github.io/state-space-workhop-ESA/state-space-walkthrough.html")[*State-Space Methods for Palaeoecological Hypothesis Testing*] — open workshop materials for state-space modelling of community and palaeoecological time series. (2024)
]
#pub[
  #link("https://github.com/QuinnAsena/resbaz2022")[*Authoring Collaborative Research Projects in Quarto*] — resources for collaborative research workflows using Git, GitHub, and Quarto (ResBaz 2022–2024).
]
#pub[
  #link("https://github.com/UoA-eResearch/fisheR")[*fisheR*] — R package for calculating Fisher's Information on ecological time-series data. (2019)
]
#pub[
  #link("https://quinnasena.shinyapps.io/r_logistic/")[*Population Growth Explorer*] — interactive Shiny app exploring population growth equations for undergraduate teaching. (2019)
]
