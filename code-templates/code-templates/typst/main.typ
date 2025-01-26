#import "./lib/setup.typ": *
#import "./lib/lt.typ": lt

#set document(
  author: "Bernd Müller",
  title: "",
  keywords: (""),
)

#show: doc => setup(doc, print: false)
#show: lt()

// #{
//   show: style-outline
//   outline(depth: 3)
// }
#let title = [
]
#set page(
  //   header: align(right)[
  //   #title
  // ]
  header: [
    #h(1fr)
    #title
  ], numbering: "1",
)

#let numbered_eq(content) = math.equation(
  block: true,
  numbering: "(1)",
  content,
)

// #set text(lang: "en", region: "US", size: 11pt, weight: 400, fallback: false)
// #show: word-count
//
// Wörter: #total-words
