
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let article(
  type: "Paper",
  title: none,
  subtitle: none,
  author: none,
  date: none,
  year: none,
  month: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "a4",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // titlepage
  set page(margin: (
    top: 1.5cm,
    bottom: 0.5cm,
    x: 0cm,
    y: 0cm
  ))

  set rect(
    width: 100%,
    inset: 5pt,
  )

  grid(
  columns: (10pt, 1fr),
  rows: (auto,20%),
  h(10pt),
  image("logo.png", width: 50%, alt: "GESIS logo")
  )
  
  rect(fill: rgb("#003c78"))[
    #align(center)[
    #text(white,font:font,size:46pt, weight: 300)[GESIS] 
    #text(white,font:font,size:28pt, weight: 700)[#type]
    ]
  ]
  v(10%)
  text(black,font:font,weight:500,size:46pt)[#h(25%) #year] 
  text(black,font:font,size:46pt,weight:500)[|]
  text(rgb("#d20064"),font:font,weight:500,size:46pt)[#month] 
  v(10%)
  
  grid(
    columns:(25%,70%),
    rows: (auto,auto),
    row-gutter: 20pt,
    h(25%),
    text(rgb("#003c78"),font:font,weight:600,size:28pt)[#title],
    h(25%),
    text(rgb("#003c78"),font:font,weight:500,size:22pt)[#subtitle]
  )

  v(10%)

  grid(
    columns: (25%,70%),
    h(25%),
    text(black,font:font,weight:400,size:22pt)[#author]
  )

  align(right+bottom)[
    #image("dots.png", width: 25%, alt: "GESIS logo")
  ]

  // body
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  
  show heading.where( level: 1 ): it => [
    #set align(left)
    #set text(rgb("#003c78"),22pt, weight: 600)
    #text(it)
    #v(-0.6cm)
    #line(length: 100%, stroke: 2pt + black)
    #v(0.3cm)
  ]

  show heading.where( level: 2 ): it => [
    #set align(left)
    #set text(rgb("#003c78"),18pt, weight: 600)
    #text(it)
    #v(0.3cm)
  ]

    show heading.where( level: 3 ): it => [
    #set align(left)
    #set text(rgb("#003c78"),16pt, weight: 600)
    #text(it)
    #v(0.3cm)
  ]


  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: 0.2pt + rgb("#003c78")
)

#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 1.5pt + rgb("#003c78"),top: 1.5pt + rgb("#003c78"))
  // } else if y < h  {
  //   (bottom: 0.1pt + rgb("#dbe3ec"))
  } else{
    (bottom: 0.4pt + rgb("#dbe3ec"))
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)