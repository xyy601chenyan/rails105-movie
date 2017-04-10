module MoviesHelper
  def render_movie_description(a)
    simple_format(a.description)
  end
end
