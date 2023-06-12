require 'rails_helper'

RSpec.describe BooksService do
  describe 'Establish connection' do
    it 'can connect to the Open Library API', :vcr do
      book_search = BooksService.new.get_books('denver,co')

      expect(book_search).to be_a Hash
      expect(book_search).to have_key :numFound
      expect(book_search[:numFound]).to be_a Integer
      expect(book_search).to have_key :docs
      expect(book_search[:docs]).to be_a Array
      expect(book_search[:docs][0]).to have_key :title
      expect(book_search[:docs][0][:title]).to be_a String
      expect(book_search[:docs][0]).to have_key :isbn
      expect(book_search[:docs][0][:isbn]).to be_a Array
      expect(book_search[:docs][0]).to have_key :publisher
      expect(book_search[:docs][0][:publisher]).to be_a Array
    end
  end
end