#let suits_symbols = (
  hearts: "{",
  diamonds: "[",
  clubs: "]",
  spades: "}",
)

#let suit_icon(suit, suit_image, icon_size) = {
  if suit_image == none {
    text(size: icon_size)[#suits_symbols.at(suit)]
  } else {
    box(height: icon_size, width: icon_size, inset: 3pt)[#suit_image]
  }
}

#let display_corner(rank, suit, suit_image, flip: false) = {
  let rotation = 0deg
  if flip {
    rotation = 180deg
  }

  let rank_str = str(rank)
  if rank == 10 {
    rank = "="
  }
  if rank == 1 {
    rank = "A"
  }

  box[#rotate(rotation)[#par(leading: 3pt)[
      #text(size: 32pt, weight: "bold")[#rank]\
      #suit_icon(suit, suit_image, 22pt)
    ]]]
}

#let pip1 = ((0, 0),)
#let pip2 = ((0, 1), (0, -1))
#let pip3 = pip2 + pip1
#let pip4 = (
  for x in (-1/2, 1/2) {
    for y in (-1, 1) {
      ((x, y),)
}})
#let pip5 = pip4 + pip1
#let pip6 = pip4 + ((-1/2, 0.0), (1/2, 0.0))
#let pip7 = pip6 + ((0.0, -1/2),)
#let pip8 = (
  for x in (-1/2, 1/2) {
    for y in (-1/2, 1/2, 3/2, -3/2) {
      ((x, y),)
}})
#let pip9 = pip8 + ((0, 0),)
#let pip10 = pip8 + ((0,-1), (0, 1))

#let pip_positions = (pip1, pip1, pip2, pip3, pip4, pip5, pip6, pip7, pip8, pip9, pip10)

#let display_center_for_numbers(rank, suit, suit_image, pip_size: 36pt) = {
  let scalex = 1.7 * pip_size
  let scaley = 1.2 * pip_size
  if rank < 1 or rank > 10 {
    rank = 1
  }
  if rank == 1 {
    pip_size = 60pt
  }

  for pip in pip_positions.at(rank) {
    let rotation = 0deg
    let dy = 0
    if pip.at(1) > 0 {
      rotation = 180deg
      if suit_image == none {
        dy = 0.3
      }
    }
    place(
      center + horizon,
      dx: pip.at(0) * scalex,
      dy: (pip.at(1)+dy) * scaley,
    )[
      #rotate(rotation)[#suit_icon(suit, suit_image, pip_size)]
    ]
  }
}


/// Ceci est une carte de jeu.
///
#let custom_playing_card(
  rank, suit,
  suit_image: none,
  suit_color: none,
  center_image: none,
  card_width: 57mm,
  card_height: 88mm,
  card_stroke: black,
  card_fill: none,
  card_inner_fill: none,
  card_margin: 3mm,
) = {
  if suit_color == none {
    suit_color = black
    if "diamonds" == suit or "hearts" == suit {
      suit_color = rgb("#ff0000")
    }
  }

  box(
    width: card_width, height: card_height,
    stroke: card_stroke, fill: card_fill,
    radius: 3mm, clip: true,
  )[
    #set align(center + horizon)
    #set text(fill: suit_color, font: "Card Characters")
    #set image(fit: "contain")
    #box(
      width: card_width - 2*card_margin,
      height: card_height - 2*card_margin,
      fill: card_inner_fill,
    )[
      #let dy = 5pt
      #place(top + left, dy: -dy)[#display_corner(rank, suit, suit_image, flip: false)]
      #place(top + right, dy: -dy)[#display_corner(rank, suit, suit_image, flip: false)]
      #place(bottom + left, dy: dy)[#display_corner(rank, suit, suit_image, flip: true)]
      #place(bottom + right, dy: dy)[#display_corner(rank, suit, suit_image, flip: true)]

      #if center_image == none and type(rank) == int {
        display_center_for_numbers(rank, suit, suit_image)
      } else if center_image != none {
        box(width: card_width/2)[#center_image]
      }

    ]
  ]
}

#let custom_playing_card_back(
  back_image: none,
  card_width: 57mm,
  card_height: 88mm,
  card_stroke: black,
  card_fill: none,
  card_inner_fill: none,
  card_margin: 3mm,
) = {
  box(
    width: card_width, height: card_height,
    stroke: card_stroke, fill: card_fill,
    radius: 3mm, clip: true,
  )[
    #set align(center + horizon)
    // #set image(fit: "contain")
    #box(
      width: card_width - 2*card_margin,
      height: card_height - 2*card_margin,
      fill: card_inner_fill,
    )[
      #back_image
    ]
  ]
}




/// test
#custom_playing_card(5, "clubs", suit_image: none, center_image: none)
#custom_playing_card(5, "clubs", suit_image: image("inputs/A_clubs.svg"), center_image: none)
#custom_playing_card_back(back_image: image("inputs/back.svg"))
// image("inputs/A_clubs.svg")
// image("inputs/clubs.svg", height: 100mm)