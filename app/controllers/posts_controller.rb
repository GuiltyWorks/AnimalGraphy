require "mini_magick"
require "numo/narray"
require "onnxruntime"

class PostsController < ApplicationController
  before_action :authenticate_user, { only: [:new, :create, :edit, :update, :destroy] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    @posts = Post.all.order(created_at: :desc)
    @tags = Tag.all.order(created_at: :desc)
  end

  def tags
    tag = params[:tag]
    tags = ["bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe"]
    if tags.include?(tag)
      @tags = Tag.where(tag.to_sym => true).order(created_at: :desc)
    else
      flash[:notice] = "タグが見つかりませんでした"
      redirect_to("/posts/index")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @tag = Tag.find_by(post_id: @post.id)
    @user = @post.user
    @likes_count = Like.where(post_id: params[:id]).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      comment: params[:comment],
      user_id: @current_user.id,
    )

    if params[:image] && @post.save
      image = params[:image]
      File.binwrite("public/post_images/#{@post.id}.jpg", image.read)

      detection_result = detection("public/post_images/#{@post.id}.jpg")

      @tag = Tag.new(
        post_id: @post.id,
        bird: detection_result[:bird],
        cat: detection_result[:cat],
        dog: detection_result[:dog],
        horse: detection_result[:horse],
        sheep: detection_result[:sheep],
        cow: detection_result[:cow],
        elephant: detection_result[:elephant],
        bear: detection_result[:bear],
        zebra: detection_result[:zebra],
        giraffe: detection_result[:giraffe],
      )
      @tag.save

      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.comment = params[:comment]

    if @post.save
      if params[:image]
        image = params[:image]
        File.binwrite("public/post_images/#{@post.id}.jpg", image.read)

        detection_result = detection("public/post_images/#{@post.id}.jpg")

        @tag = Tag.find_by(post_id: @post.id)
        @tag.bird = detection_result[:bird]
        @tag.cat = detection_result[:cat]
        @tag.dog = detection_result[:dog]
        @tag.horse = detection_result[:horse]
        @tag.sheep = detection_result[:sheep]
        @tag.cow = detection_result[:cow]
        @tag.elephant = detection_result[:elephant]
        @tag.bear = detection_result[:bear]
        @tag.zebra = detection_result[:zebra]
        @tag.giraffe = detection_result[:giraffe]

        @tag.save
      end

      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    @tag = Tag.find_by(post_id: params[:id])
    @tag.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def detection(img_name)
    model = OnnxRuntime::Model.new("public/object_detection/yolov3.onnx")
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt")

    img = MiniMagick::Image.open(img_name)
    image_size = [[img.height, img.width]]
    img.combine_options do |b|
      b.resize "416x416"
      b.gravity "center"
      b.background "transparent"
      b.extent "416x416"
    end
    img_data = Numo::SFloat.cast(img.get_pixels)
    img_data /= 255.0
    image_data = img_data.transpose(2, 0, 1).expand_dims(0).to_a

    output = model.predict(input_1: image_data, image_shape: image_size)

    boxes, scores, indices = output.values
    results = indices.map do |idx|
      { class: idx[1], score: scores[idx[0]][idx[1]][idx[2]], box: boxes[idx[0]][idx[2]] }
    end

    img = MiniMagick::Image.open(img_name)
    animals = [:bird, :cat, :dog, :horse, :sheep, :cow, :elephant, :bear, :zebra, :giraffe]
    result = { bird: false, cat: false, dog: false, horse: false, sheep: false, cow: false, elephant: false, bear: false, zebra: false, giraffe: false }

    results.each do |r|
      hue = r[:class] * 100 / 80.0
      label = labels[r[:class]].chomp.to_sym

      # 判定結果が動物以外なら無視
      if animals.any? { |animal| label == animal }
        result[label] = true
        puts "----Detection----"
        puts result[label]
      end
    end

    return result
  end
end
