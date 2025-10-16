#let card_width = sys.inputs.at("card_width", default: 57mm)
#let card_height = sys.inputs.at("card_height", default: 88mm)
#let card_margin = sys.inputs.at("card_margin", default: 3mm)
#let inner_margin = sys.inputs.at("inner_margin", default: 3mm)

#let playing_card_template(doc) = [
  #set text(font: "Orkney")
  #set page(width: card_width, height: card_height, margin: card_margin)
  #doc
]

#let default_suit_colors = (
  spades: black,
  clubs: black,
  hearts: rgb("#ff0000"),
  diamonds: rgb("#ff0000"),
)

#let icon(suit, size, suits_colors) = {
  if "." in suit {
    return box[#image(suit, height: size)]
  } else {
    let suits = (
      hearts: "♥",
      diamonds: "♦",
      clubs: "♣",
      spades: "♠"
    )
    return text(size: size, suits_colors.at(suit))[#suits.at(suit)]
  }
}

#let ranks = (
  "1": "A",
  "2": "2",
  "3": "3",
  "4": "4",
  "5": "5",
  "6": "6",
  "7": "7",
  "8": "8",
  "9": "9",
  "10": "10",
  "11": "J",
  "12": "Q",
  "13": "K",
)

#let corners = (
  (alignment.top + alignment.left, inner_margin, inner_margin),
  (alignment.top + alignment.right, -inner_margin, inner_margin),
  (alignment.bottom + alignment.left, inner_margin, -inner_margin),
  (alignment.bottom + alignment.right, -inner_margin, -inner_margin),
)

#let pip1 = ((0, 0),)
#let pip2 = ((0, 1), (0, -1))
#let pip3 = pip2 + ((0, 0),)
#let pip4 = ((-0.5, 1), (0.5, 1), (-0.5, -1), (0.5, -1))
#let pip5 = pip4 + ((0, 0),)
#let pip6 = pip4 + ((-0.5, 0.0), (0.5, 0.0))
#let pip7 = pip6 + ((0.0, -0.5),)
#let pip8 = pip6 + ((0, 0.5), (0, -0.5))
#let pip9 = pip6 + ((0, 1.5), (0, -1.5), (0, -0.5))
#let pip10 = pip8 + ((-0.5, -0.5), (0.5, -0.5))

#let pip_positions = (
  pip1,
  pip1,
  pip2,
  pip3,
  pip4,
  pip5,
  pip6,
  pip7,
  pip8,
  pip9,
  pip10,
)

#let display_center_for_numbers(rank, suit, suits_colors, pip_size: 42pt) = {
  let scale = 1.2 * pip_size

  for pip in pip_positions.at(rank) {
    place(
      center + horizon,
      dx: pip.at(0) * scale,
      dy: pip.at(1) * scale,
    )[
      #if pip.at(1) > 0 {
        rotate(180deg)[
          #icon(suit, pip_size, suits_colors)
        ]
      } else {
        icon(suit, pip_size, suits_colors)
      }
      
    ]
  }

}

#let display_corner(rank_str, suit, suits_colors, size: 32pt, flip: false) = align(center)[
  
  #let rotation = 0deg
  #if flip {
    rotation = 180deg
  }

  #box(width: size)[#align(center)[#rotate(rotation)[
    #par(leading: 6pt)[
      #text(size: size, weight: "bold", fill: suits_colors.at(suit))[#rank_str]\
      #icon(suit, size/1.5, suits_colors)
    ]
  ]
  ]]
]

/// Ceci est une carte de jeu.
///
/// - rank (int): an int between 0 and 13. 0 for Joker, 1 for Ace, 11 for Jack, 12 for Queen, 13 for King.
/// - suit (str): "hearts", "diamonds", "clubs", "spades"
/// - center (str or none): If none, display pips for numbers. If str, path to image file for face cards and aces.
/// - suit_icon (str or none): If none, display default suit icon. If str, path to custom suit icon.
/// - suit_colors (dictionary): testest
/// - ranks_label (dictionary): test
/// -> 
#let playing_card(
  rank, suit, center_img: none, suit_icon: none,
  suits_colors: (
    spades: black,
    clubs: black,
    hearts: rgb("#ff0000"),
    diamonds: rgb("#ff0000"),
  ),
  ranks_labels: ("★", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K")
) = {
  assert(rank >= 0 and rank <= 13, message: "Rank must be between 0 and 13")

  let flip = false
  for pos in corners {
    if pos.at(0).y == alignment.bottom {
      flip = true
    }
    place(pos.at(0), dx: pos.at(1), dy: pos.at(2))[#display_corner(ranks_labels.at(rank), suit, suits_colors, flip: flip)]
  }
  if center_img == none {
    display_center_for_numbers(rank, suit, suits_colors)
  } else {
    align(center + horizon)[#image(center_img, width: card_width/2)]
  }
}

#let playing_card_back(img) = {
  align(center + horizon)[#image(img, width: card_width, height: card_height)]
}

/// test
#show: playing_card_template
#playing_card(7, "hearts", center_img: none)