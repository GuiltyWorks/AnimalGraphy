class NewsController < ApplicationController
  def index
    tag = Tag.find_by(id: params[:key])
    if params[:key] != "general" && tag.nil?
      flash[:notice] = "項目が見つかりませんでした。"
      redirect_to "/news/general"
      return
    end

    word = params[:key] == "general" ? CGI.escape("動物") : CGI.escape(tag.name)
    url = "https://news.google.com/search?q=#{word}&hl=ja&gl=JP&ceid=JP%3Aja"
    charset = nil
    html = OpenURI.open_uri(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    @news_list = []
    links = doc.xpath("//h3[@class='ipQwMb ekueJc gEATFF RD0gLb']/a")
    images = doc.xpath("//img[@class='tvs3Id QwxBBf']").map { |image| image.attr("src") }
    links.each_with_index do |link, index|
      @news_list << {
        "url" => "https://news.google.com" + link.attr("href").slice(1, link.attr("href").length - 1),
        "title" => link.text,
        "image" => images[index].present? ? images[index] : "",
      }
    end

    @active_list = make_active_list(params[:key])
  end

  def make_active_list(key)
    active_list = {
      "general" => "inactive",
    }
    Tag.all.each do |tag|
      active_list[tag.name] = "inactive"
    end
    active_list[key] = "active"

    return active_list
  end
end
