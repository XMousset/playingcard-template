#import "playing_card.typ" : playing_card, playing_card_back, playing_card_template
#show : playing_card_template

#let center_img(rank, suit) = {
  let rank_name = ranks.at(rank)
  let suit_name = "black"
  if suit == "hearts" or suit == "diamonds" {
    suit_name = "red"
  }

  if rank in ("11", "12", "13") {
    return "inputs/" + rank_name + "_" + suit_name + ".svg"
  }
  if rank == "10" {
    return "inputs/" + rank_name + "_" + suit + ".jpg"
  }
  if rank == "1" {
    return "inputs/" + rank_name + "_" + suit + ".svg"
  }
}



// #if rank in ("1", "10", "11", "12", "13") {
//   align(center + horizon)[#image(center_img(rank, suit), width: card_width/2)]
// } else {
//   display_center_for_numbers()(rank, suit, suit_colors.at(suit))
// }


// main
// #for suit in ("spades", "hearts", "diamonds", "clubs") {
//   for rank in ("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13") {
//     card(rank, suit)
//     pagebreak()
//     back("inputs/back.svg")
//     pagebreak()
//   }
// }

// #align(center + horizon)[#image("inputs/joker_1.svg", width: card_width/1.5)]
// #pagebreak()
// #align(center + horizon)[#image("inputs/joker_2.svg", width: card_width/1.5)]

// test cases
#playing_card("2", "diamonds")
// #pagebreak()
// #playing_card("1", "spades")
// #pagebreak()
// #playing_card("1", "hearts")
// #pagebreak()
// #playing_card("1", "clubs")
// #pagebreak()
// #playing_card_back("inputs/back.svg")