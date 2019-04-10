module GuessHelper
  def generate_obfuscated_word(word, guessed_letters)
    word.chars.reduce("") { |string, char| string + (guessed_letters.include?(char) ? " #{char} " : " _ ") }
  end
end
