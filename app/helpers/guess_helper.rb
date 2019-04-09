module GuessHelper
  def generate_obfuscated_word(word, guessed_letters)
    string = ""

    word.split("").each do |char|
      string += guessed_letters.include?(char) ? " #{char} " : " _ "
    end

    string
  end
end
