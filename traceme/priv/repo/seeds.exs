#
alias Traceme.Store.{Castle, Minion}

Castle.clear()
Minion.clear()

Castle.add(
  name: "DragonStone",
  desc: "Blackwater Bay. House of Targaryen."
)
Castle.add(
  name: "Castle Black",
  desc: "Kingsroad. Night's watch headquaters."
)
Castle.add(
  name: "Red Keep",
  desc: "King's landing. Residence for king of the Andals and the First Men."
)
Castle.add(
  name: "Baretheon",
  desc: "Rules the Stormlands on the eastern coast of Westeros"
)

cast = [
  "Jon Snow",
  "Daenarys Targarien",
  "Melisandre",
  "Tyrion Lanister",
  "Sansa Stark",
  "Khal Drogo"
]

Enum.each( Enum.with_index(cast), fn({c, index}) ->
    Minion.add(name: c, avatar: "m#{index+1}")
end)
