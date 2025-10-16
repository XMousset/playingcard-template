#let suits_symbols = (
  hearts: sym.suit.heart,
  diamonds: sym.suit.diamond,
  clubs: sym.suit.club,
  spades: sym.suit.spade
)

#let corners_pos = (
  (top + left, false),
  (top + right, false),
  (bottom + left, true),
  (bottom + right, true),
)

#let suit_icon(suit, suit_image, icon_size) = {
  if suit_image == none {
    text(size: icon_size)[#suits_symbols.at(suit)]
  } else {
    box[#image(suit_image, height: icon_size)]
  }
}

#let display_corner(rank, suit, suit_image, flip: false) = {
  let rotation = 0deg
  if flip {
    rotation = 180deg
  }
  box[#rotate(rotation)[#par(leading: 6pt)[
      #text(size: 32pt, weight: "bold")[#rank]\
      #suit_icon(suit, suit_image, 22pt)
    ]]]
}

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

#let pip_positions = (pip1, pip1, pip2, pip3, pip4, pip5, pip6, pip7, pip8, pip9, pip10)

#let display_center_for_numbers(rank, suit, suit_image, pip_size: 42pt) = {
  let scale = 1.2 * pip_size

  for pip in pip_positions.at(int(rank)) {
    place(
      center + horizon,
      dx: pip.at(0) * scale,
      dy: pip.at(1) * scale,
    )[
      #if pip.at(1) > 0 {
        rotate(180deg)[
          #suit_icon(suit, suit_image, pip_size)
        ]
      } else {
        suit_icon(suit, suit_image, pip_size)
      }
      
    ]
  }
}


/// Ceci est une carte de jeu.
///
/// - rank (int): an int between 0 and 13. 0 for Joker, 1 for Ace, 11 for Jack, 12 for Queen, 13 for King.
/// - suit (str): "hearts", "diamonds", "clubs", "spades"
/// - center (str or none): If none, display pips for numbers. If str, path to image file for face cards and aces.
/// - suit_icon (str or none): If none, display default suit icon. If str, path to custom suit icon.
/// - suit_colors (dictionary): testest
/// - ranks_label (dictionary): test
/// -> 
#let custom_playing_card(
  rank, suit,
  suit_image: none,
  suit_color: none,
  center_img: none,
  card_width: 57mm,
  card_height: 88mm,
  card_stroke: none,
  card_fill: gray, // white
  card_margin: 3mm,
) = {
  if suit_color == none {
    suit_color = black
    if "diamonds" == suit or "hearts" == suit {
      suit_color = rgb("#ff0000")
    }
  }
  if type(rank) == int {
    rank = str(rank)
  }

  box(
    width: card_width, height: card_height,
    stroke: card_stroke, fill: card_fill,
    radius: 3mm, clip: true,
  )[
    #set align(center + horizon)
    #set text(fill: suit_color)
    #box(
      width: card_width - 2*card_margin,
      height: card_height - 2*card_margin,
      fill: white, // none
    )[
      #for pos in corners_pos {
        align(pos.at(0))[#display_corner(rank, suit, suit_image, flip: pos.at(1))]
      }

      #if center_img == none and rank in ("1", "2", "3", "4", "5", "6", "7", "8", "9", "10") {
        display_center_for_numbers(rank, suit, suit_image)
      } else if center_img != none {
        image(center_img, width: card_width/2)
      }

    ]
  ]
  
  
}

#let playing_card_back(img) = {
  align(center + horizon)[#image(img, width: default_card_width, height: card_height)]
}


// #let custom_full_page_card = {
//   set page(width: card_width, height: card_height, margin: card_margin)
// }


/// test
#custom_playing_card(8, "clubs", center_img: none)