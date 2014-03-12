#encoding: utf-8
require 'bigdecimal'
require 'spec_helper.rb'

describe BigDecimal do

  describe "input" do
    it "rounds correctly" do
      input = BigDecimal.new("10.202")
      input.round(2).should eq(BigDecimal.new("10.20"))
      input.round(2).to_s.should eq(BigDecimal.new("10.20").to_s)
    end

    it "splits levs" do
      input = BigDecimal.new("10.20")
      levs = input.fix.to_i
      levs.should eq(10)
    end

    it "splits stotinki" do
      input = BigDecimal.new("10.20")
      stotinki = input.frac.to_s('F').gsub("0.", '')
      stotinki.should eq("2")
      stotinki = stotinki+"0" if stotinki.length == 1
      stotinki.should eq("20")
      stotinki = stotinki.to_i
      stotinki.should eq(20)
    end
  end

  describe ".slovom_short" do
    it "converts stotinki into a valid string" do
      number = BigDecimal.new("00.56")
      number.slovom_short.should eq("56ст")

      number = BigDecimal.new("00.04")
      number.slovom_short.should eq("04ст")

      number = BigDecimal.new("00.00")
      number.slovom_short.should eq("")
    end

    it "converts levs into a valid string" do
      number = BigDecimal.new("1.00")
      number.slovom_short.should eq("един лев")

      number = BigDecimal.new("14.00")
      number.slovom_short.should eq("четиринадесет лв")

      number = BigDecimal.new("156320010.00")
      number.slovom_short.should eq("сто петдесет и шест милиона триста и двадесет хиляди и десет лв")
    end
  end

  describe ".slovom" do
    it "converts stotinki into a valid string" do
      number = BigDecimal.new("00.56")
      number.slovom.should eq("петдесет и шест стотинки")

      number = BigDecimal.new("00.05")
      number.slovom.should eq("пет стотинки")

      number = BigDecimal.new("00.12")
      number.slovom.should eq("дванадесет стотинки")

      number = BigDecimal.new("00.23")
      number.slovom.should eq("двадесет и три стотинки")

      number = BigDecimal.new("00.99")
      number.slovom.should eq("деветдесет и девет стотинки")
    end

    it "converts levs and stotinki combo into a valid string" do
      number = BigDecimal.new("1.56")
      number.slovom.should eq("един лев и петдесет и шест стотинки")

      number = BigDecimal.new("3.05")
      number.slovom.should eq("три лева и пет стотинки")

      number = BigDecimal.new("10.20")
      number.slovom.should eq("десет лева и двадесет стотинки")

      number = BigDecimal.new("20.30")
      number.slovom.should eq("двадесет лева и тридесет стотинки")

      number = BigDecimal.new("14.12")
      number.slovom.should eq("четиринадесет лева и дванадесет стотинки")

      number = BigDecimal.new("71.23")
      number.slovom.should eq("седемдесет и един лева и двадесет и три стотинки")

      number = BigDecimal.new("101.99")
      number.slovom.should eq("сто и един лева и деветдесет и девет стотинки")

      number = BigDecimal.new("514.76")
      number.slovom.should eq("петстотин и четиринадесет лева и седемдесет и шест стотинки")

      number = BigDecimal.new("1264.34")
      number.slovom.should eq("хиляда двеста шестдесет и четири лева и тридесет и четири стотинки")

      number = BigDecimal.new("5317.04")
      number.slovom.should eq("пет хиляди триста и седемнадесет лева и четири стотинки")

      number = BigDecimal.new("14000.15")
      number.slovom.should eq("четиринадесет хиляди лева и петнадесет стотинки")

      number = BigDecimal.new("78381.92")
      number.slovom.should eq("седемдесет и осем хиляди триста осемдесет и един лева и деветдесет и две стотинки")

      number = BigDecimal.new("132011.16")
      number.slovom.should eq("сто тридесет и две хиляди и единадесет лева и шестнадесет стотинки")

      number = BigDecimal.new("1783085.21")
      number.slovom.should eq("един милион седемстотин осемдесет и три хиляди и осемдесет и пет лева и двадесет и една стотинки")

      number = BigDecimal.new("11316081.07")
      number.slovom.should eq("единадесет милиона триста и шестнадесет хиляди и осемдесет и един лева и седем стотинки")

      number = BigDecimal.new("159354101.33")
      number.slovom.should eq("сто петдесет и девет милиона триста петдесет и четири хиляди сто и един лева и тридесет и три стотинки")

      number = BigDecimal.new("56237203102.71")
      number.slovom.should eq("петдесет и шест милиарда двеста тридесет и седем милиона двеста и три хиляди сто и два лева и седемдесет и една стотинки")

      number = BigDecimal.new("31804319906444.10")
      number.slovom.should eq("тридесет и един трилиона осемстотин и четири милиарда триста и деветнадесет милиона деветстотин и шест хиляди четиристотин четиридесет и четири лева и десет стотинки")

      number = BigDecimal.new("1.01")
      number.slovom.should eq("един лев и една стотинка")
    end

    it "converts levs into a valid string" do
      number = BigDecimal.new("1.00")
      number.slovom.should eq("един лев")

      number = BigDecimal.new("2.00")
      number.slovom.should eq("два лева")

      number = BigDecimal.new("14.00")
      number.slovom.should eq("четиринадесет лева")

      number = BigDecimal.new("17.00")
      number.slovom.should eq("седемнадесет лева")

      number = BigDecimal.new("18.00")
      number.slovom.should eq("осемнадесет лева")

      number = BigDecimal.new("20.00")
      number.slovom.should eq("двадесет лева")

      number = BigDecimal.new("30.00")
      number.slovom.should eq("тридесет лева")

      number = BigDecimal.new("76.00")
      number.slovom.should eq("седемдесет и шест лева")

      number = BigDecimal.new("293.00")
      number.slovom.should eq("двеста деветдесет и три лева")

      number = BigDecimal.new("303.00")
      number.slovom.should eq("триста и три лева")

      number = BigDecimal.new("452.00")
      number.slovom.should eq("четиристотин петдесет и два лева")

      number = BigDecimal.new("811.00")
      number.slovom.should eq("осемстотин и единадесет лева")

      number = BigDecimal.new("1000.00")
      number.slovom.should eq("хиляда лева")

      number = BigDecimal.new("1200.00")
      number.slovom.should eq("хиляда и двеста лева")

      number = BigDecimal.new("1407.00")
      number.slovom.should eq("хиляда четиристотин и седем лева")

      number = BigDecimal.new("2000.00")
      number.slovom.should eq("две хиляди лева")

      number = BigDecimal.new("2800.00")
      number.slovom.should eq("две хиляди и осемстотин лева")

      number = BigDecimal.new("10000.00")
      number.slovom.should eq("десет хиляди лева")

      number = BigDecimal.new("14100.00")
      number.slovom.should eq("четиринадесет хиляди и сто лева")

      number = BigDecimal.new("59374.00")
      number.slovom.should eq("петдесет и девет хиляди триста седемдесет и четири лева")

      number = BigDecimal.new("100000.00")
      number.slovom.should eq("сто хиляди лева")

      number = BigDecimal.new("200300.00")
      number.slovom.should eq("двеста хиляди и триста лева")

      number = BigDecimal.new("776315.00")
      number.slovom.should eq("седемстотин седемдесет и шест хиляди триста и петнадесет лева")

      number = BigDecimal.new("1000000.00")
      number.slovom.should eq("един милион лева")

      number = BigDecimal.new("156320010.00")
      number.slovom.should eq("сто петдесет и шест милиона триста и двадесет хиляди и десет лева")

      number = BigDecimal.new("1000001.00")
      number.slovom.should eq("един милион и един лева")

      number = BigDecimal.new("1000000000.00")
      number.slovom.should eq("един милиард лева")

      number = BigDecimal.new("121000000000.00")
      number.slovom.should eq("сто двадесет и един милиарда лева")

      number = BigDecimal.new("1000000000000.00")
      number.slovom.should eq("един трилион лева")

      number = BigDecimal.new("511000000000000.00")
      number.slovom.should eq("петстотин и единадесет трилиона лева")
    end
  end

end
