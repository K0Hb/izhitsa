# frozen_string_literal: true

module Izhitsa
  ALL_LATTERS = %w[А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я]
  UPPER_CONSONANT_LETTERS = %w[Б В Г Д Ж З К Л М Н П Р С Т Ф Х Ц Ч Ш Щ].freeze
  LOWER_CONSONANT_LETTERS = %w[б в г д ж з к л м н п р с т ф х ц ч ш щ].freeze
  UPPER_VOWEL_LETTERS = %w[А Е Ё И Й О У Ы Э Ю Я].freeze
  LOWER_VOWEL_LETTERS = %w[а е ё и й о у ы э ю я].freeze

  FITA_WORDS = %w[Агафья Анфимъ Афанасій Афина Варфоломей Голіафъ Евфимій Марфа Матфей Мефодій Нафанаилъ Парфенонъ Пифагоръ Руфь Саваофъ
    Тимофей Эсфирь Іудифь Фаддей Фекла Фемида Фемистоклъ Феодоръ Федя Феодосій Феодосія Феодотъ Феофанъ Феофилъ Ферапонтъ Фома Фоминична
    Афины Афонъ Вифанія Вифезда Вифинія Вифлеемъ Вифсаида Гефсиманія Голгофа Карфагенъ Коринфъ Марафонъ Парфія Парфенонъ Эфіопія Фаворъ
    Феодосія Фермофилы Фессалія Фессалоники Фивы Фракія Коринфяне Парфяне Скифы Эфіопы Фиване Анафема Акафистъ Апофеозъ Апофегма Арифметика
    Дифирамбъ Ефимоны Кафолическій Кафедра Кафизма Кифара Левіафанъ Логарифмъ Марафонъ Мифъ Мифологія Монофелитство Орфографія Орфоэпія
    Пафосъ Рифма Эфиръ Фиміамъ Фита].freeze

  IZHITSA_WORDS = %w[миро иподіаконъ ипостась символъ синодъ].freeze

  # пишется .рѣ. && .лѣ.
  IAT_WORDS = %w[апрель хлебъ].freeze

  # иностранные слова, в которых ять не пишется
  IAT_FOREIGN_WORDS = %w[ариѳметика математика алгебра литература метафора кинетика генетика реле].freeze

  EGO_WORDS = %w[вашего всего его моего нашего него нечего ничего своего сего твоего чего].freeze

  def self.convert(str)
    return str unless str.is_a? String

    each_all_words(str) do |word|
      word = use_rule_1(word)
      word = use_rule_2(word)
      word = use_rule_3(word)
      word = use_rule_4(word)
      word = use_rule_5(word)
      word = use_rule_6(word)
      word = use_rule_7(word)
      word = use_rule_8(word)

      word
    end
  end

  private

  class << self
    def each_all_words(text, &block)
      text.gsub(/[а-яА-ЯёЁ]{2,}/) { |word| yield word }
    end

    def use_rule_1(word) # окончания на Ъ
      return word unless word.downcase.end_with?(*LOWER_CONSONANT_LETTERS)

      word.downcase.end_with?(*LOWER_CONSONANT_LETTERS)

      x = (word[-1] == word[-1].upcase) ? "Ъ" : "ъ"

      "#{word}#{x}"
    end

    def use_rule_2(word) # i
      word.gsub(/(и)([#{UPPER_VOWEL_LETTERS}#{LOWER_VOWEL_LETTERS}])/, 'і\2')
        .gsub(/(И)([#{UPPER_VOWEL_LETTERS}#{LOWER_VOWEL_LETTERS}])/, 'І\2')
        .gsub(/(Й)([#{UPPER_VOWEL_LETTERS}#{LOWER_VOWEL_LETTERS}])/, 'І\2')
        .gsub(/(й)([#{UPPER_VOWEL_LETTERS}#{LOWER_VOWEL_LETTERS}])/, 'і\2')
    end

    def use_rule_3(word) # Фита(ѳ)
      return word unless FITA_WORDS.include?(word.capitalize)

      word.gsub("ф", "ѳ").gsub("Ф", "Ѳ")
    end

    def use_rule_4(word) # Ижица(ѵ)
      return word unless IZHITSA_WORDS.include?(word.downcase)

      word.gsub("и", "ѵ").gsub("и", "Ѵ")
    end

    def use_rule_5(word) # приставки
      return word unless word.downcase.match?(/^(ис|вос|рас|рос|нис)с.*/) ||
        word.downcase.start_with?("бес", "черес", "чрес")

      word.sub("с", "з").sub("С", "З")
    end

    def use_rule_6(word) # окончание
      return word if EGO_WORDS.include?(word.downcase)

      if word.downcase.match?(/.*[жшчщ](его|егос)/)
        word.sub("его", "аго").sub("ЕГО", "АГО").sub("егося", "агося").sub("ЕГОСЯ", "АГОСЯ")
      elsif word.downcase.end_with?("его", "егося")
        word.sub("его", "яго").sub("ЕГО", "ЯГО").sub("егося", "ягося").sub("ЕГОСЯ", "ЯГОСЯ")
      else
        word
      end
    end

    def use_rule_7(word) # Ять(ѣ)
      # Дописать правила, самый сложный блок. TODO
      return word if IAT_FOREIGN_WORDS.include?(word.downcase)

      return word if word.downcase.count("ё") == 1 && word.downcase.count("е").zero?

      return word if word.downcase.count("е") == 2 && word.downcase.match?(/(ере|еле)/) && !word.downcase.end_with?("ейшій", "ЕЙШІЙ", "еть", "ЕТЬ")

      return word if word.downcase.count("е") == 1 && word.downcase.match?(/#{LOWER_CONSONANT_LETTERS}(ре|ле)/) &&
        !IAT_WORDS.include?(word.downcase) && !word.downcase.end_with?("ейшій", "ЕЙШІЙ", "еть", "ЕТЬ") && !word.downcase.match?(/([#{LOWER_CONSONANT_LETTERS}])(е)$/)
      return word if word.downcase.count("е") == 1 && word.downcase.start_with?("без", "бес") && !word.downcase.match?("бесъ")
      return word if word.downcase.count("е") == 1 && word.end_with?("его")

      word = word.gsub(/([#{LOWER_CONSONANT_LETTERS}])(е)/, '\1ѣ').gsub(/([#{UPPER_CONSONANT_LETTERS}])(Е)/, '\1Ѣ') if word.downcase.count("е") == 1
      word = word.gsub(/([#{LOWER_CONSONANT_LETTERS}])(е)$/, '\1ѣ').gsub(/([#{UPPER_CONSONANT_LETTERS}])(Е)$/, '\1Ѣ')
      word = word.gsub("ей", "ѣй").gsub("ЕЙ", "ѢЙ") if word.end_with?("ей", "ЕЙ")
      word = word.gsub("ее", "ѣе").gsub("ЕЕ", "ѢЕ") if word.end_with?("ее", "ЕЕ")
      word = word.gsub("ейшій", "ѣйшій").gsub("ЕЙШІЙ", "ѢЙШІЙ") if word.end_with?("ейшій", "ЕЙШІЙ")
      word = word.gsub("еть", "ѣть").gsub("ЕТЬ", "ѢТЬ") if word.end_with?("еть", "ЕТЬ")

      word
    end

    def use_rule_8(word) # Ё
      word.gsub("ё", "е").gsub("Ё", "Е")
    end
  end
end
