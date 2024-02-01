# frozen_string_literal: true

RSpec.describe Izhitsa do
  [1, 1.2, Class.new, {}, [], true, nil, :sym].each do |data|
    it { expect(subject.convert(data)).to eq(data) }
  end

  it { expect(subject.convert("Хлеб")).to eq("Хлебъ") }
  it { expect(subject.convert("Хлеб и обед")).to eq("Хлебъ и обедъ") }
  it { expect(subject.convert("Санкт-Петербург")).to eq("Санктъ-Петербургъ") }
  it { expect(subject.convert("уж замуж невтерпеж")).to eq("ужъ замужъ невтерпежъ") }
end
