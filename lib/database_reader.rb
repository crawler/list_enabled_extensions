require 'json'
require 'sqlite3'
require 'pathname'
require 'forwardable'

class DatabaseReader
  extend Forwardable
  class Error < StandardError; end
  class NotFoundError < Error; end

  def initialize(path:, query: nil)
    @path = Pathname.new(path)
    @query = query || default_query
  end

  delegate default_query: :'self.class'

  def extensions
    @extensions ||=
      JSON.parse(query_extensions.dig(0, 1) || raise(NotFoundError, "Unexpected query result #{query_extensions}"))
          .map { |ext| ext['id'] }
  end

  private

  def query_extensions
    connection.execute(query)
  rescue SQLite3::Exception => e
    raise Error, "Error querying database: #{e}"
  ensure
    connection.close if connection
  end

  def connection
    return @connection if @connection && !@connection.closed?

    @connection = SQLite3::Database.new(path.to_s)
  rescue SQLite3::Exception => e
    raise Error, "Error opening database: #{e} (path: #{path})"
  end

  public

  attr_reader :path, :query

  class << self
    def default_query
      <<~SQL
        SELECT * FROM ItemTable WHERE key LIKE 'extensionsIdentifiers/enabled'
      SQL
    end
  end
end
