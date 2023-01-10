class ApplicationService
  include ActiveModel::Validations

  def self.call(*args)
    new(*args).call
  end
end