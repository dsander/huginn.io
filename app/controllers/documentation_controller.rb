# frozen_string_literal: true

class DocumentationController < ApplicationController
  before_action :assign_template

  def index; end

  def show
    render :index
  end

  private

  def assign_template
    @template = params[:id].presence || 'about'
    redirect_to documentation_index_path unless templates.include?(@template)
  end

  def templates
    Rails.cache.fetch('documentation_partials') do
      Dir.glob(Rails.root.join('app/views/documentation/_*.md')).map do |path|
        File.basename(path, '.md')[1..-1]
      end
    end
  end
end
