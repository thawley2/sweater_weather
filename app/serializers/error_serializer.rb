class ErrorSerializer
  def self.serialize(error)
    { 
      errors: [
        {
          detail: error
          }
          ]
        }
  end
end