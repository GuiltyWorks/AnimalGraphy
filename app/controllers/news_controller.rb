class NewsController < ApplicationController
  def index
    tag = Tag.find_by(id: params[:key])
    if params[:key] != "general" && tag.nil?
      redirect_to "/news/general", notice: "項目が見つかりませんでした。"
      return
    end

    word = params[:key] == "general" ? CGI.escape("動物") : CGI.escape(tag.name)
    uri = "https://news.google.com/rss/search?q=#{word}&hl=ja&gl=JP&ceid=JP:ja"
    @news_list = []
    open(uri) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        @news_list << {
          "title" => item.title,
          "link" => item.link,
        }
      end
    end

    @news_list = Kaminari.paginate_array(@news_list).page(params[:page]).per(5)
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
