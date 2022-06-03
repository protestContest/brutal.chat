defmodule BrutalChat.Hash do
  @hash_base 14_695_981_039_346_656_037
  @hash_prime 1_099_511_628_211

  def fnv(value) do
    String.to_charlist(value)
    |> Enum.reduce(@hash_base, &(Bitwise.bxor(&1, &2) * @hash_prime))
  end

  def fnv(value, salt) do
    [salt | String.to_charlist(value)]
    |> Enum.reduce(@hash_base, &(Bitwise.bxor(&1, &2) * @hash_prime))
  end

  def shuffle(list, salt) do
    shuffle(list, [], String.codepoints(salt), 0, 0)
  end

  defp shuffle([], dst, _salt, _salt_index, _index), do: dst

  defp shuffle(src, dst, salt, salt_index, index) do
    salt_index = Integer.mod(salt_index, Enum.count(salt))
    index = Integer.mod(index + salt_index, Enum.count(src))
    val = Enum.at(src, index)

    shuffle(List.delete_at(src, index), [val | dst], salt, salt_index + 1, index)
  end
end
