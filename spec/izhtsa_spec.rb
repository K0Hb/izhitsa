# frozen_string_literal: true

RSpec.describe Izhitsa do
  [1, 1.2, Class.new, {}, [], true, nil, :sym].each do |data|
    it { expect(subject.convert(data)).to eq(data) }
  end

  it { expect(subject.convert("some text in English")).to eq("some text in English") }

  it { expect(subject.convert("Хлеб")).to eq("Хлебъ") }
  it { expect(subject.convert("ХЛЕБ")).to eq("ХЛЕБЪ") }
  it { expect(subject.convert("клещ")).to eq("клещъ") }
  it { expect(subject.convert("Хлеб и обед")).to eq("Хлебъ и обедъ") }
  it { expect(subject.convert("Санкт-Петербург")).to eq("Санктъ-Петербургъ") }
  it { expect(subject.convert("уж замуж невтерпеж")).to eq("ужъ замужъ невтерпежъ") }

  it { expect(subject.convert("линия")).to eq("линія") }
  it { expect(subject.convert("ЛИНИЯ")).to eq("ЛИНІЯ") }
  it { expect(subject.convert("Майор, Йод")).to eq("Маіоръ, Іодъ") }
  it { expect(subject.convert("другие, синий.")).to eq("другіе, синій.") }

  it { expect(subject.convert("Афины, Миф, Федя, арифметика")).to eq("Аѳины, Миѳъ, Ѳедя, ариѳметика") }

  it { expect(subject.convert("миро, Иподіаконъ, ипостась")).to eq("мѵро, Иподъіаконъ, ѵпостась") }

  it { expect(subject.convert("Ёж, мёд")).to eq("Ежъ, медъ") }

  it { expect(subject.convert("Сергей и апрель")).to eq("Сергѣй и апрѣль") }
  it { expect(subject.convert("СЕРГЕЙ И АПРЕЛЬ")).to eq("СЕРГѢЙ И АПРѢЛЬ") }

  it { expect(subject.convert("Рассказ, воссоеденить и россыпь")).to eq("Разсказъ, возсоеденить и розсыпь") }
  it { expect(subject.convert("Бесполезный, бестактный и бессоница")).to eq("Безполезный, безтактный и безсоница") }
  it { expect(subject.convert("РАССКАЗ И БЕССОНИЦА")).to eq("РАЗСКАЗЪ И БЕЗСОНИЦА") }
  it { expect(subject.convert("распад")).to eq("распадъ") }

  it { expect(subject.convert("вещего, павшего и учащегося")).to eq("вещаго, павшаго и учащагося") }
  it { expect(subject.convert("синего, среднего")).to eq("синяго, средняго") }
  it { expect(subject.convert("вашего, нашего и своего")).to eq("вашего, нашего и своего") }
end
