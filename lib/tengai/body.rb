module Tengai
  class Body
    attr_reader :data

    def self.find(client, body)
      data = client.cmd('String' => body, 'Match' => /<cr>:\s*$/)
      self.new(data)
    end

    def initialize(data)
      @data = data
    end
  end
end
