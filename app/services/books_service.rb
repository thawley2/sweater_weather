class BooksService
  def get_books(location)
    get_url("/search.json?q=#{location}")
  end

  private
    def conn 
      Faraday.new(url: 'https://openlibrary.org')
      end
    end

    def get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
end