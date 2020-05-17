require "nokogiri"
require "open-uri"

class NewsController < ApplicationController
  def index
    @active_list = {
      general: "inactive",
      bird: "inactive",
      cat: "inactive",
      dog: "inactive",
      horse: "inactive",
      sheep: "inactive",
      cow: "inactive",
      elephant: "inactive",
      bear: "inactive",
      zebra: "inactive",
      giraffe: "inactive",
    }
    @active_list[params[:key].to_sym] = "active"

    url_list = {
      general: "https://news.google.com/search?q=%E5%8B%95%E7%89%A9&hl=ja&gl=JP&ceid=JP%3Aja",
      bird: "https://news.google.com/search?q=%E9%B3%A5&hl=ja&gl=JP&ceid=JP%3Aja",
      cat: "https://news.google.com/search?q=%E7%8C%AB&hl=ja&gl=JP&ceid=JP%3Aja",
      dog: "https://news.google.com/search?q=%E7%8A%AC&hl=ja&gl=JP&ceid=JP%3Aja",
      horse: "https://news.google.com/search?q=%E9%A6%AC&hl=ja&gl=JP&ceid=JP%3Aja",
      sheep: "https://news.google.com/search?q=%E7%BE%8A&hl=ja&gl=JP&ceid=JP%3Aja",
      cow: "https://news.google.com/search?q=%E7%89%9B&hl=ja&gl=JP&ceid=JP%3Aja",
      elephant: "https://news.google.com/search?q=%E8%B1%A1&hl=ja&gl=JP&ceid=JP%3Aja",
      bear: "https://news.google.com/search?q=%E7%86%8A&hl=ja&gl=JP&ceid=JP%3Aja",
      zebra: "https://news.google.com/search?q=%E3%82%B7%E3%83%9E%E3%82%A6%E3%83%9E&hl=ja&gl=JP&ceid=JP%3Aja",
      giraffe: "https://news.google.com/search?q=%E3%82%AD%E3%83%AA%E3%83%B3&hl=ja&gl=JP&ceid=JP%3Aja",
    }

    url = url_list[params[:key].to_sym]
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    links = doc.xpath("//h3[@class='ipQwMb ekueJc gEATFF RD0gLb']/a")
    urls = links.map do |link|
      "https://news.google.com" + link.attr("href").slice(1, link.attr("href").length - 1)
    end
    @urls = urls
    titles = links.map do |link|
      link.text
    end
    @titles = titles

    images = doc.xpath("//figure[@class='AZtY5d fvuwob MbMxpc d7hoq']/img").map do |image|
      image.attr("src")
    end
    @images = images
  end
end
