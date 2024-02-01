# frozen_string_literal: true

require "izhitsa/version"

module Izhitsa
  ALL_LATTERS = %w[А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я]
  UPPER_CONSONANT_LETTERS = %w[Б В Г Д Ж З К Л М Н П Р С Т Ф Х Ц Ч Ш Щ]
  LOWER_CONSONANT_LETTERS = %w[б в г д ж з к л м н п р с т ф х ц ч ш щ]

  def self.convert(str)
    return str unless str.is_a? String

    str.gsub(/[а-яА-Я]{2,}/) do |word|
      if word.downcase.end_with?(*LOWER_CONSONANT_LETTERS)
        x = "ъ"
        x.upcase! if word[-1] == word[-1].upcase

        "#{word}#{x}"
      end
    end
  end
end
