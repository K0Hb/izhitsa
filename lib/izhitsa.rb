# frozen_string_literal: true

require "izhitsa/version"

module Izhitsa
  ALL_LATTERS = %w[А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я]
  UPPER_CONSONANT_LETTERS = %w[Б В Г Д Ж З К Л М Н П Р С Т Ф Х Ц Ч Ш Щ].freeze
  LOWER_CONSONANT_LETTERS = %w[б в г д ж з к л м н п р с т ф х ц ч ш щ].freeze
  UPPER_VOWEL_LETTERS = %w[А Е Ё И Й О У Ы Э Ю Я].freeze
  LOWER_VOWEL_LETTERS = %w[а е ё и й о у ы э ю я].freeze

  def self.convert(str)
    return str unless str.is_a? String

    each_all_words(str) do |word|
      word = use_rule_1(word)
      word = use_rule_2(word)

      word
    end
  end

  private

  def self.each_all_words(text, &block)
    text.gsub(/[а-яА-Я]{2,}/) { |word| yield word }
  end

  def self.use_rule_1(word)
    return word unless word.downcase.end_with?(*LOWER_CONSONANT_LETTERS)

    word.downcase.end_with?(*LOWER_CONSONANT_LETTERS)

    x = word[-1] == word[-1].upcase ? "Ъ" : "ъ"

    word = "#{word}#{x}"
  end

  def self.use_rule_2(word)
    word = word.gsub(/(и)([#{LOWER_VOWEL_LETTERS}])/, 'і\2')
    word = word.gsub(/(И)([#{UPPER_VOWEL_LETTERS}])/, 'І\2')
  end
end
