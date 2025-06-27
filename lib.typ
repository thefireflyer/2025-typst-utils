//============================================================================//
// #import "@preview/cetz:0.4.0"
// #import "@preview/fletcher:0.5.8"
// #import "@preview/commute:0.3.0"
#import "@preview/curryst:0.5.1": prooftree, rule
// #import "@preview/finite:0.5.0"
// #import "@preview/lovelace:0.3.0": pseudocode-list
#import "@preview/simplebnf:0.1.1": Or, Prod, bnf
//============================================================================//
#let burgundy = rgb(101, 0, 21)
#let burgundylight = color.hsl(347.52deg, 40%, 80%)
#let darkteal = rgb("#005b5b")
#let darkteallight = color.hsl(180deg, 40%, 80%)
//============================================================================//

#let currentelem(sel, def) = {
  let x = query(sel.after(here())).at(0, default: none)
  if x != none and x.location().page() == here().page() { return x }
  let xs = query(sel.before(here()))
  if xs.len() != 0 { xs.last() }
  def
}

#let breadcrumbs() = {
  let h1 = currentelem(heading.where(level: 1), none)
  let h2 = currentelem(heading.where(level: 2), none)
  if h1 != none and h2 != none and h2.location().page() < h1.location().page() {
    h2 = none
  }

  if h1 != none {
    h1.body
  }
  if h2 != none {
    " / "
    h2.body
  }
}

//----------------------------------------------------------------------------//

#let boxed(textcolor, bgcolor, fgcolor, tag, body) = [
  #set align(left)
  #block(breakable: true, [
    #block(sticky: true, fill: bgcolor, stroke: bgcolor, inset: 5pt, text(fill: white, tag))
    #block(above: 0pt, fill: bgcolor, stroke: bgcolor, width: 100%, inset: 1pt, sticky: true, breakable: true, block(
      fill: fgcolor,
      stroke: fgcolor,
      breakable: true,
      width: 100%,
      above: 0pt,
      inset: 5pt,
      body,
    ))
  ])
  #label(tag)
]

//----------------------------------------------------------------------------//

#let exercise(number, body) = boxed(white, darkteal, darkteallight, "Exercise " + number, body)
#let theorem(number, body) = boxed(white, burgundy, burgundylight, "Theorem " + number, body)

//----------------------------------------------------------------------------//

#let frontmatter() = [
  #page(header: none, footer: none, [
    #align(center, pad(y: 01em, text(size: 2em, weight: "bold", context document.title)))
    #outline(title: none, indent: 2em, depth: 2)
  ])
]

//----------------------------------------------------------------------------//

#let code_exec(data) = {
  let lines = data.split("\n")
  let body = "▸ " + lines.at(0)

  if lines.at(lines.len() - 1) == "" { lines = lines.slice(0, -1) }

  for line in lines.slice(1) {
    body += "\n  " + line
  }

  raw(body)
}

//============================================================================//
#let doc(title: "Untitled", body) = [
  #set document(title: title)

  #set page(header: context [
    #breadcrumbs()
    #h(1fr)
    #counter(page).display()
    #line(length: 100%)
  ])
  #set heading(numbering: "1.")
  #set math.equation(numbering: "(1)")

  #show heading: it => align(center, it)
  #show heading.where(level: 1): it => [#pagebreak() #it]
  #show outline.entry.where(level: 1): it => [#v(0.2em) #text(weight: "bold", it)]
  #show "Proof.": [_*Proof.*_]
  #show "Lemma.": [_*Lemma.*_]
  #show "Definition.": [_*Definition.*_]
  #show "Verified.": it => box(fill: darkteal, inset: 5pt, text(fill: white, it))
  #show math.equation: it => {
    show regex("`.+"): it => math.mono(it.text.slice(1))
    it
  }
  #show regex(":Exercise \w+.\w+.\w+"): it => link(label(it.text.slice(1)), it.text.slice(1))
  #show regex(":Theorem \w+.\w+.\w+"): it => link(label(it.text.slice(1)), it.text.slice(1))

  #show sym.emptyset: sym.diameter

  #let arrow-long-not = $cancel(-->, length: #35%, angle: #20deg)$
  #show "-/->": arrow-long-not
  #let multi-step-eval = $attach(-->, tr: *)$
  #show "-->*": multi-step-eval

  #show figure.where(kind: "code"): it => {
    set align(left)
    text(weight: "bold", it.caption)
    pad(left: 0.5cm, it.body)
  }

  #let filepat = "[\w_\./-]+"
  #let tagpat = "\#[/\.\w-]+"

  #show raw: it => {
    set text(font: "Fira Code")
    it
  }

  #show raw.where(lang: none, block: true): it => {
    let hdr = it.text.match(regex(
      "(?m) *\{\.(\w+) *(?:\.build)? *"
        + "(?:("
        + tagpat
        + ")|(?:file=("
        + filepat
        + "))|(?:target=\"("
        + filepat
        + ")\")) *"
        + "(?:deps=\"("
        + filepat
        + ")\")?"
        + " *\}\n",
    ))
    if hdr == none { return it }

    let lang = hdr.captures.at(0)
    let tag = hdr.captures.at(1)
    let file = hdr.captures.at(2)
    let target = hdr.captures.at(3)

    let caption
    let body = it.text.slice(hdr.end)

    if tag != none { caption = "<<" + tag.slice(1) + ">>" }
    if file != none { caption = file }
    if target != none { caption = target }

    set text(size: 11pt, font: "Libertinus Serif")
    [
      #figure(caption: raw(caption), kind: "code", supplement: "", numbering: none, raw(body, lang: lang))
      #label(caption)
    ]
  }

  #show regex(":![_/\.\w-]+"): it => link(label(it.text.slice(2)), raw(it.text.slice(2)))

  #show regex(":/[_/\.\w-]+"): it => link(label("<<" + it.text.slice(2) + ">>"), raw("<<" + it.text.slice(2) + ">>"))

  #frontmatter()
  #body
]

//============================================================================//
