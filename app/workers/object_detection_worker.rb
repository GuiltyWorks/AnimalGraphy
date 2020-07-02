class ObjectDetectionWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(post_id)
    post = Post.find_by(id: post_id)
    post.tag_ids = detection(post.image.read)
    post.save
  end

  private

  def detection(binary_image)
    model = OnnxRuntime::Model.new("public/object_detection/yolov3.onnx")
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt").map(&:chomp)

    img = MiniMagick::Image.read(binary_image)
    image_size = [ [ img.height, img.width ] ]
    img.combine_options do |b|
      b.resize "416x416"
      b.gravity "center"
      b.background "transparent"
      b.extent "416x416"
    end
    img_data = Numo::SFloat.cast(img.get_pixels)
    img_data /= 255.0
    image_data = img_data.transpose(2, 0, 1).expand_dims(0).to_a
    output = model.predict(input_1: image_data, image_shape: image_size) # 物体検出
    boxes, scores, indices = output.values
    results = indices.map { |idx| { class: idx[1], score: scores[idx[0]][idx[1]][idx[2]], box: boxes[idx[0]][idx[2]] } }

    tag_ids = []
    results.each do |r|
      label = labels[r[:class]]
      score = r[:score]
      # 判定結果が動物かつ確率が50%以上の場合のみ検出扱い
      if label != "other" && score > 0.5
        tag = Tag.find_by(name: label)
        tag_ids.push(tag&.id)
      end
    end

    return tag_ids.compact
  end
end
