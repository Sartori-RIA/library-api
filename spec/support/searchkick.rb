# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    # reindex models
    [Book].each(&:reindex)

    # and disable callbacks
    Searchkick.disable_callbacks
  end

  config.around(:each, :search) do |example|
    Searchkick.callbacks(nil) do
      example.run
    end
  end
end
