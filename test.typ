#let card(cardname) = {
    let (card, suit) = cardname.split(" of ")
    let suits = (
      "hearts": sym.suit.heart,
      "diamonds": sym.suit.diamond,
      "clubs": sym.suit.club,
      "spades": sym.suit.spade,
    )
    let suit_colors = (
      "hearts": "red",
      "diamonds": "red",
      "clubs": "black",
      "spades": "black",
    )

    [
      #box(stroke: 1pt, height: 3em, width: 2em)[
        #set text(fill: eval(suit_colors.at(suit)))
        #align(left + top, suits.at(suit))
        #align(horizon + center, card)
        #align(bottom + right, suits.at(suit))
      ]
    ]
  }

// #card("A of hearts")
#let aaa = 3
#if type(aaa) == int {
  str(aaa)
}
#str(aaa)