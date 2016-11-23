# frozen_string_literal: true
module TestHelpers
  def load_json_data(path)
    JSON.parse(load_data(path))
  end

  def load_data(path)
    File.read(File.join(Rails.root, path))
  end
end
